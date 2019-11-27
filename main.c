#include <stdlib.h>
#include <stdarg.h>
#include <emscripten.h>
#include <mruby.h>
#include <mruby/irep.h>
#include <mruby/array.h>
#include <mruby/proc.h>
#include <mruby/compile.h>
#include <mruby/dump.h>
#include <mruby/string.h>
#include <mruby/variable.h>
#include <mruby/throw.h>

mrb_value app;
mrb_state *mrb;

mrb_value load_file(char* name) {
  mrb_value v;
  mrbc_context *c;
  c = mrbc_context_new(mrb);

  int ai = mrb_gc_arena_save(mrb);
  FILE *fp = fopen(name, "r");
  if (fp == NULL) {
    fprintf(stderr, "Cannot open file: %s\n", name);
    return mrb_nil_value();
  }
  printf("[Prism] Loading: %s\n", name);
  mrbc_filename(mrb, c, name);
  v = mrb_load_file_cxt(mrb, fp, c);
  fclose(fp);
  mrb_gc_arena_restore(mrb, ai);
  return v;
}

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

mrb_value
http_request(mrb_state *mrb, mrb_value self){
  mrb_value url, id;
  mrb_get_args(mrb, "SS", &url, &id);

  EM_ASM_({
    const response = fetch(UTF8ToString($0));
    const id = UTF8ToString($1);

    response.then(r => r.text()).then(text => {
      Module.ccall('http_response',
        'void',
        ['string', 'string'],
        [JSON.stringify({body: text}), id]
      );

      render();
    });
  }, RSTRING_PTR(url), RSTRING_PTR(id));
  return mrb_nil_value();
}

mrb_value require(mrb_state *mrb, mrb_value self){
  mrb_value path;
  mrb_get_args(mrb, "S", &path);

  load_file(RSTRING_PTR(path));
  if (mrb->exc) {
    mrb_print_error(mrb);
    mrb->exc = NULL;
  }

  return mrb_nil_value();
}

int
main(int argc, const char * argv[])
{
  struct RClass *dom_class, *http_class;

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

  http_class = mrb_define_class(mrb, "InternalHTTP", mrb->object_class);
  mrb_define_class_method(
    mrb,
    http_class,
    "http_request",
    http_request,
    MRB_ARGS_REQ(1)
  );

  http_class = mrb_define_class(mrb, "InternalHTTP", mrb->object_class);
  mrb_define_class_method(
    mrb,
    http_class,
    "http_request",
    http_request,
    MRB_ARGS_REQ(1)
  );

  mrb_define_module_function(
    mrb,
    mrb_module_get(mrb, "Kernel"),
    "require",
    require,
    MRB_ARGS_REQ(1)
  );

  return 0;
}

int load(char* main) {
  const char* class_name;
  load_file("src/prism.rb");
  app = load_file(main);
  mrb_gc_register(mrb, app);

  return 0;
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

void http_response(char* text, char* id) {
  mrb_value str = mrb_str_new_cstr(mrb, text);
  mrb_value str2 = mrb_str_new_cstr(mrb, id);
  mrb_funcall(mrb, app, "http_response", 2, str, str2);

  if (mrb->exc) {
    mrb_print_error(mrb);
    mrb->exc = NULL;
  }
}

