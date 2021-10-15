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
#include <mruby/error.h>

mrb_value app;
mrb_state *mrb;
mrbc_context *c;

mrb_value
get_window_reference(mrb_state *mrb, mrb_value self){
  return mrb_fixnum_value(EM_ASM_INT({
    return getWindowReference();
  }));
}

mrb_value
get_document_reference(mrb_state *mrb, mrb_value self){
  return mrb_fixnum_value(EM_ASM_INT({
    return getDocumentReference();
  }));
}


mrb_value
clear_args(mrb_state *mrb, mrb_value self) {
  EM_ASM_({
    return clearArgs();
  });

  return mrb_nil_value();
}

mrb_value
set_arg_string(mrb_state *mrb, mrb_value self) {
  mrb_value index, value;
  mrb_get_args(mrb, "iS", &index, &value);

  EM_ASM_({
    return setArgString($0, UTF8ToString($1), $2);
  }, index, RSTRING_PTR(value));

  return mrb_nil_value();
}

mrb_value
call_method(mrb_state *mrb, mrb_value self) {
  mrb_value reference, name, arg_count, args;
  mrb_get_args(mrb, "iS", &reference, &name);

  EM_ASM_({
    return callMethod($0, UTF8ToString($1), $2);
  }, reference, RSTRING_PTR(name), arg_count);

  return mrb_nil_value();
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

int
main(int argc, const char * argv[])
{
  struct RClass *dom_class, *http_class, *binding_class;

  mrb = mrb_open();
  c = mrbc_context_new(mrb);

  binding_class = mrb_define_class(mrb, "InternalBindings", mrb->object_class);
  mrb_define_class_method(
    mrb,
    binding_class,
    "window_reference",
    get_window_reference,
    MRB_ARGS_REQ(0)
  );

  mrb_define_class_method(
    mrb,
    binding_class,
    "document_reference",
    get_document_reference,
    MRB_ARGS_REQ(0)
  );

  mrb_define_class_method(
    mrb,
    binding_class,
    "call_method",
    call_method,
    MRB_ARGS_REQ(2)
  );

  mrb_define_class_method(
    mrb,
    binding_class,
    "clear_args",
    clear_args,
    MRB_ARGS_REQ(0)
  );

  mrb_define_class_method(
    mrb,
    binding_class,
    "set_arg_string",
    set_arg_string,
    MRB_ARGS_REQ(2)
  );

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

  return 0;
}

mrb_value load_file(char* name) {
  mrb_value v;
  FILE *fp = fopen(name, "r");
  if (fp == NULL) {
    fprintf(stderr, "Cannot open file: %s\n", name);
    return mrb_nil_value();
  }
  printf("[Prism] Loading: %s\n", name);
  mrbc_filename(mrb, c, name);
  v = mrb_load_file_cxt(mrb, fp, c);
  fclose(fp);
  if (mrb->exc) {
    mrb_print_error(mrb);
    mrb->exc = NULL;
  }
  return v;
}

void print_backtrace(char* msg) {
  mrb_exc_raise(mrb, mrb_exc_new_str(mrb, E_SCRIPT_ERROR, mrb_str_new_cstr(mrb, msg)));
  mrb_print_backtrace(mrb);
}

int load(char* main, char* config) {
  const char* class_name;
  mrb_define_global_const(mrb, "JSON_CONFIG", mrb_str_new_cstr(mrb, config));
  load_file("prism-ruby/prism.rb");
  load_file("prism-ruby/bindings/bindings.rb");
  app = load_file(main);
  struct RClass* prism_module = mrb_module_get(mrb, "Prism");
  struct RClass* mount_class = mrb_class_get_under(mrb, prism_module, "Mount");

  if(!mrb_obj_is_kind_of(mrb, app, mount_class)) {
    class_name = mrb_obj_classname(mrb, app);

    fprintf(stderr, "[Prism] Error starting app.\n  Expected '%s' to return an instance of Prism::Mount but got a %s instead.\n  Did you remember to call Prism.mount on the last line?\n", main, class_name);

    return 1;
  }
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
