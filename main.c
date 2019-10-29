#include <emscripten.h>
#include <stdarg.h>
#include <mruby.h>
#include <mruby/irep.h>
#include <mruby/array.h>
#include <mruby/proc.h>
#include <mruby/compile.h>
#include <mruby/dump.h>
#include <mruby/string.h>
#include <mruby/variable.h>
#include <mruby/throw.h>
#include "bundle.c"

mrb_value app;
mrb_state *mrb;


mrb_value
add_event_listener(mrb_state *mrb, mrb_value self){
  mrb_value selector, event, id;
  mrb_get_args(mrb, "SSS", &selector, &event, &id);

  EM_ASM_({
    var selector = UTF8ToString($0);
    var eventName = UTF8ToString($1);
    var id = UTF8ToString($2);
    var elements;

    if (selector === 'document') {
      elements = [window.document];
    } else if (selector === 'body') {
      elements = [window.document.body];
    } else {
      elements = document.querySelectorAll(selector);
    }

    for (var i = 0; i < elements.length; i++) {
      var element = elements[i];

      element.addEventListener(eventName, function(event) {
        Module.ccall(
          'event',
          'void',
          ['string', 'string', 'string'],
          [stringifyEvent(event), id]
        );

        render();
      });
    };
  }, RSTRING_PTR(selector), RSTRING_PTR(event), RSTRING_PTR(id));
  return mrb_nil_value();
}

int
main(int argc, const char * argv[])
{
  struct RClass *dom_class;

  mrb = mrb_open();

  if (!mrb) { /* handle error */ }
  dom_class = mrb_define_class(mrb, "InternalDOM", mrb->object_class);
  mrb_define_class_method(
    mrb,
    dom_class,
    "add_event_listener",
    add_event_listener,
    MRB_ARGS_REQ(3)
  );

  app = mrb_load_irep(mrb, bundle);
  mrb_gc_register(mrb, app);

  return 1;
}

char* render() {
  mrb_value result = mrb_funcall(mrb, app, "render", 0);
  if (mrb->exc) {
    mrb_print_error(mrb);
    mrb->exc = NULL;
  }
  return RSTRING_PTR(result);
}

void dispatch(char* message) {
  mrb_value str = mrb_str_new_cstr(mrb, message);
  mrb_gc_register(mrb, str);
  mrb_funcall(mrb, app, "dispatch", 1, str);
  if (mrb->exc) {
    mrb_print_error(mrb);
    mrb->exc = NULL;
  }
  mrb_gc_unregister(mrb, str);
}

void event(char* message, char* id) {
  mrb_value str = mrb_str_new_cstr(mrb, message);
  mrb_value str2 = mrb_str_new_cstr(mrb, id);
  mrb_funcall(mrb, app, "event", 2, str, str2);

  if (mrb->exc) {
    mrb_print_error(mrb);
    mrb->exc = NULL;
  }
}

// main
//
// make the ruby component
// return a reference?
//
// dispatch
//
// call the ruby component with an event triggered by event handler
// we might need the reference?
//
// what is the mruby api for calling methods?

/**
 * Gets a class.
 * @param mrb The current mruby state.
 * @param name The name of the class.
 * @return [struct RClass *] A reference to the class.
*/
// MRB_API struct RClass * mrb_class_get(mrb_state *mrb, const char *name);
