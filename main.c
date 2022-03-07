#include <stdlib.h>
#include <stdarg.h>
#include <emscripten.h>
#include <mruby.h>
#include <mruby/irep.h>
#include <mruby/numeric.h>
#include <mruby/class.h>
#include <mruby/data.h>
#include <mruby/array.h>
#include <mruby/proc.h>
#include <mruby/compile.h>
#include <mruby/dump.h>
#include <mruby/string.h>
#include <mruby/variable.h>
#include <mruby/throw.h>
#include <mruby/error.h>

// EXPORT is used by the build-prism-runtime script to determine which functions can be used by ccall
#define EXPORT

mrb_value app;
struct RClass* external_references;
struct RClass* js_reference_class;
mrb_state *mrb;
mrbc_context *c;

static void mrb_reference_free(mrb_state *mrb, int *p) {
  MAIN_THREAD_EM_ASM_INT({
    return Prism.freeReference($0);
  }, *p);
}

static const struct mrb_data_type mrb_reference_type = {
  "$i_mrb_reference_type", mrb_reference_free
};


mrb_value mrb_reference(mrb_state *mrb, int maybe_int) {
  mrb_value inner_value;

  mrb_value args[1] = { mrb_fixnum_value(maybe_int) };

  inner_value = mrb_obj_new(mrb, js_reference_class, 1, args);

  return inner_value;
}

static mrb_value mrb_reference_initialize(mrb_state *mrb, mrb_value self) {
  mrb_int *data = (mrb_int*)DATA_PTR(self);
  if (data) mrb_reference_free(mrb, data);
  mrb_data_init(self, NULL, &mrb_reference_type);
  mrb_int val;
  mrb_get_args(mrb, "i", &val);
  data = (mrb_int*)mrb_malloc(mrb, sizeof *data);
  *data = val;
  mrb_data_init(self, data, &mrb_reference_type);
  return self;
}

static mrb_value mrb_reference_value(mrb_state *mrb, mrb_value self) {
  mrb_int *data = (mrb_int*)DATA_PTR(self);
  return mrb_fixnum_value(*data);
}

mrb_value
get_window_reference(mrb_state *mrb, mrb_value self){
  return mrb_reference(mrb, MAIN_THREAD_EM_ASM_INT({
    return Prism.getWindowReference();
  }));
}

mrb_value
get_prism_bindings_reference(mrb_state *mrb, mrb_value self){
  return mrb_reference(mrb, MAIN_THREAD_EM_ASM_INT({
    return Prism.getPrismBindingsReference();
  }));
}

mrb_value
get_document_reference(mrb_state *mrb, mrb_value self){
  return mrb_reference(mrb, MAIN_THREAD_EM_ASM_INT({
    return Prism.getDocumentReference();
  }));
}

mrb_value
get_args_reference(mrb_state *mrb, mrb_value self){
  return mrb_reference(mrb, MAIN_THREAD_EM_ASM_INT({
    return Prism.getArgsReference();
  }));
}

mrb_value
clear_args(mrb_state *mrb, mrb_value self) {
  MAIN_THREAD_EM_ASM({
    return Prism.clearArgs();
  });

  return mrb_nil_value();
}

mrb_value
set_arg_string(mrb_state *mrb, mrb_value self) {
  mrb_value index, value;
  mrb_get_args(mrb, "iS", &index, &value);

  MAIN_THREAD_EM_ASM({
    return Prism.setArgString($0, UTF8ToString($1));
  }, index, RSTRING_PTR(value));

  return mrb_nil_value();
}

mrb_value
set_arg_number(mrb_state *mrb, mrb_value self) {
  mrb_value index, value;
  mrb_get_args(mrb, "ii", &index, &value);

  MAIN_THREAD_EM_ASM({
    return Prism.setArgNumber($0, $1);
  }, index, value);

  return mrb_nil_value();
}

mrb_value
set_arg_value(mrb_state *mrb, mrb_value self) {
  mrb_value index, reference;
  mrb_get_args(mrb, "ii", &index, &reference);

  MAIN_THREAD_EM_ASM({
    return Prism.setArgValue($0, $1);
  }, index, reference);

  return mrb_nil_value();
}

mrb_value
set_arg_callback(mrb_state *mrb, mrb_value self) {
  mrb_value index, reference;
  mrb_get_args(mrb, "ii", &index, &reference);

  MAIN_THREAD_EM_ASM({
    return Prism.setArgCallback($0, $1);
  }, index, reference);

  return mrb_nil_value();
}

mrb_value
set_object_value_string(mrb_state *mrb, mrb_value self) {
  mrb_value index, name, value;
  mrb_get_args(mrb, "iSS", &index, &name, &value);

  MAIN_THREAD_EM_ASM({
    return Prism.setObjectValue($0, UTF8ToString($1), UTF8ToString($2));
  }, index, RSTRING_PTR(name), RSTRING_PTR(value));

  return mrb_nil_value();
}

mrb_value
set_object_value_number(mrb_state *mrb, mrb_value self) {
  mrb_value index, name;
  mrb_float value;
  mrb_get_args(mrb, "iSf", &index, &name, &value);

  MAIN_THREAD_EM_ASM({
    return Prism.setObjectValue($0, UTF8ToString($1), $2);
  }, index, RSTRING_PTR(name), value);

  return mrb_nil_value();
}

mrb_value
set_object_value(mrb_state *mrb, mrb_value self) {
  mrb_value index, name, value;
  mrb_get_args(mrb, "iSi", &index, &name, &value);

  MAIN_THREAD_EM_ASM({
    return Prism.setObjectValueFromReference($0, UTF8ToString($1), $2);
  }, index, RSTRING_PTR(name), value);

  return mrb_nil_value();
}

mrb_value
set_object_undefined(mrb_state *mrb, mrb_value self) {
  mrb_value index, name, value;
  mrb_get_args(mrb, "iS", &index, &name);

  MAIN_THREAD_EM_ASM({
    return Prism.setObjectValue($0, UTF8ToString($1), undefined);
  }, index, RSTRING_PTR(name));

  return mrb_nil_value();
}

mrb_value
set_object_null(mrb_state *mrb, mrb_value self) {
  mrb_value index, name, value;
  mrb_get_args(mrb, "iS", &index, &name);

  MAIN_THREAD_EM_ASM({
    return Prism.setObjectValue($0, UTF8ToString($1), null);
  }, index, RSTRING_PTR(name));

  return mrb_nil_value();
}

mrb_value
set_object_ruby_value(mrb_state *mrb, mrb_value self) {
  mrb_value index, name, value;
  mrb_get_args(mrb, "iSi", &index, &name, &value);

  MAIN_THREAD_EM_ASM({
    return Prism.setObjectValueFromRubyReference($0, UTF8ToString($1), $2);
  }, index, RSTRING_PTR(name), value);

  return mrb_nil_value();
}

mrb_value
call_method(mrb_state *mrb, mrb_value self) {
  mrb_value reference, name;
  mrb_get_args(mrb, "iS", &reference, &name);

  MAIN_THREAD_EM_ASM({
    return Prism.callMethod($0, UTF8ToString($1));
  }, reference, RSTRING_PTR(name));

  return mrb_nil_value();
}

mrb_value
call_method_reference(mrb_state *mrb, mrb_value self) {
  mrb_value this_reference, reference;
  mrb_get_args(mrb, "ii", &this_reference, &reference);

  return mrb_reference(mrb, MAIN_THREAD_EM_ASM_INT({
    return Prism.callMethodReturningReference($0, $1);
  }, this_reference, reference));
}

mrb_value
call_constructor(mrb_state *mrb, mrb_value self) {
  mrb_value reference;
  mrb_get_args(mrb, "i", &reference);

  return mrb_reference(mrb, MAIN_THREAD_EM_ASM_INT({
    return Prism.callConstructor($0);
  }, reference));
}

EM_JS(char*, get_value_string_, (mrb_value reference), {
  var string = Prism.getValueString(reference);
  var lengthBytes = lengthBytesUTF8(string.toString()) + 1;
  var stringOnWasmHeap = _malloc(lengthBytes);

  stringToUTF8(string.toString(), stringOnWasmHeap, lengthBytes);

  return stringOnWasmHeap;
});

mrb_value
get_value_string(mrb_state *mrb, mrb_value self) {
  mrb_value reference;
  mrb_get_args(mrb, "i", &reference);

  char* value = get_value_string_(reference);
  mrb_value return_str = mrb_str_new_cstr(mrb, value);

  free(value);

  return return_str;
}

mrb_value
get_value_number(mrb_state *mrb, mrb_value self) {
  mrb_value reference;
  mrb_get_args(mrb, "i", &reference);

  return mrb_float_value(mrb, MAIN_THREAD_EM_ASM_DOUBLE({
    return Prism.getValueNumber($0);
  }, reference));
}

mrb_value
get_value_reference(mrb_state *mrb, mrb_value self) {
  mrb_value reference, name;
  mrb_get_args(mrb, "iS", &reference, &name);

  return mrb_reference(mrb, MAIN_THREAD_EM_ASM_INT({
    return Prism.getValueReference($0, UTF8ToString($1));
  }, reference, RSTRING_PTR(name)));
}

mrb_value
get_type_of(mrb_state *mrb, mrb_value self) {
  mrb_value reference, name;
  mrb_get_args(mrb, "i", &reference);

  char* value = (char*)MAIN_THREAD_EM_ASM_INT({
    var string = Prism.getTypeOf($0, UTF8ToString($1));
    var lengthBytes = lengthBytesUTF8(string.toString()) + 1;
    var stringOnWasmHeap = _malloc(lengthBytes);

    stringToUTF8(string.toString(), stringOnWasmHeap, lengthBytes);

    return stringOnWasmHeap;

  }, reference);

  mrb_value return_str = mrb_str_new_cstr(mrb, value);

  free(value);

  return return_str;
}

mrb_value
get_ruby_reference_id(mrb_state *mrb, mrb_value self) {
  mrb_value reference, name;
  mrb_get_args(mrb, "i", &reference);

  int value = MAIN_THREAD_EM_ASM_INT({
    return Prism.getRubyReferenceId($0);
  }, reference);

  return mrb_fixnum_value(value);
}

mrb_value
make_callback_reference(mrb_state *mrb, mrb_value self) {
  mrb_value index, reference;
  mrb_get_args(mrb, "i", &reference);

  return mrb_reference(mrb, MAIN_THREAD_EM_ASM_INT({
    return Prism.makeCallbackReference($0);
  }, reference));
}

mrb_value
is_function_constructor(mrb_state *mrb, mrb_value self) {
  mrb_value reference;
  mrb_get_args(mrb, "i", &reference);

  int value;

  value = MAIN_THREAD_EM_ASM_INT({
    return Prism.checkIfFunctionIsContructor($0);
  }, reference);

  return mrb_bool_value(value);
}

EM_JS(char*, get_arg_string_, (mrb_value index), {
  var string = Prism.getArgString(index);
  var lengthBytes = lengthBytesUTF8(string.toString()) + 1;
  var stringOnWasmHeap = _malloc(lengthBytes);

  stringToUTF8(string.toString(), stringOnWasmHeap, lengthBytes);

  return stringOnWasmHeap;
});

mrb_value
get_arg_string(mrb_state *mrb, mrb_value self) {
  mrb_value index;
  mrb_get_args(mrb, "i", &index);

  char* value = get_arg_string_(index);
  mrb_value return_str = mrb_str_new_cstr(mrb, value);

  free(value);

  return return_str;
}

mrb_value
get_arg_count(mrb_state *mrb, mrb_value self) {
  return mrb_int_value(mrb, MAIN_THREAD_EM_ASM_INT({
    return Prism.getArgCount();
  }));
}


mrb_value
get_arg_number(mrb_state *mrb, mrb_value self) {
  mrb_value index;
  mrb_get_args(mrb, "i", &index);

  return mrb_reference(mrb, MAIN_THREAD_EM_ASM_INT({
    return Prism.getArgNumber($0);
  }, index));
}

mrb_value
get_arg_reference(mrb_state *mrb, mrb_value self) {
  mrb_value index;
  mrb_get_args(mrb, "i", &index);

  return mrb_reference(mrb, MAIN_THREAD_EM_ASM_INT({
    return Prism.getArgReference($0);
  }, index));
}

EM_JS(char*, get_arg_class_name_, (mrb_value index), {
  var string = Prism.getArgClassName(index);
  var lengthBytes = lengthBytesUTF8(string.toString()) + 1;
  var stringOnWasmHeap = _malloc(lengthBytes);

  stringToUTF8(string.toString(), stringOnWasmHeap, lengthBytes);

  return stringOnWasmHeap;
});

mrb_value
get_arg_class_name(mrb_state *mrb, mrb_value self) {
  mrb_value index;
  mrb_get_args(mrb, "i", &index);

  char* value = get_arg_class_name_(index);
  mrb_value return_str = mrb_str_new_cstr(mrb, value);

  free(value);

  return return_str;
}


mrb_value
add_event_listener(mrb_state *mrb, mrb_value self){
  mrb_value selector, event, id;
  mrb_get_args(mrb, "SSS", &selector, &event, &id);

  MAIN_THREAD_EM_ASM({
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
          [Prism.stringifyEvent(event), id]
        );

        Prism.render();
      });
    };
  }, RSTRING_PTR(selector), RSTRING_PTR(event), RSTRING_PTR(id));
  return mrb_nil_value();
}

EXPORT int main(int argc, const char * argv[])
{
  struct RClass *dom_class, *binding_class;

  mrb = mrb_open();
  c = mrbc_context_new(mrb);

  js_reference_class = mrb_define_class(mrb, "JSReference", mrb->object_class);
  MRB_SET_INSTANCE_TT(js_reference_class, MRB_TT_DATA);
  mrb_define_method(mrb, js_reference_class, "initialize", mrb_reference_initialize, MRB_ARGS_REQ(1));
  mrb_define_method(mrb, js_reference_class, "value", mrb_reference_value, MRB_ARGS_REQ(0));
  mrb_define_method(mrb, js_reference_class, "to_i", mrb_reference_value, MRB_ARGS_REQ(0));

  binding_class = mrb_define_class(mrb, "InternalBindings", mrb->object_class);

  mrb_define_class_method(
    mrb,
    binding_class,
    "prism_bindings_reference",
    get_prism_bindings_reference,
    MRB_ARGS_REQ(0)
  );

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
    "get_args_reference",
    get_args_reference,
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
    "call_method_reference",
    call_method_reference,
    MRB_ARGS_REQ(2)
  );

  mrb_define_class_method(
    mrb,
    binding_class,
    "call_constructor",
    call_constructor,
    MRB_ARGS_REQ(1)
  );


  mrb_define_class_method(
    mrb,
    binding_class,
    "get_value_string",
    get_value_string,
    MRB_ARGS_REQ(1)
  );

  mrb_define_class_method(
    mrb,
    binding_class,
    "get_value_number",
    get_value_number,
    MRB_ARGS_REQ(1)
  );

  mrb_define_class_method(
    mrb,
    binding_class,
    "get_value_reference",
    get_value_reference,
    MRB_ARGS_REQ(2)
  );

  mrb_define_class_method(
    mrb,
    binding_class,
    "get_arg_count",
    get_arg_count,
    MRB_ARGS_REQ(0)
  );


  mrb_define_class_method(
    mrb,
    binding_class,
    "get_arg_string",
    get_arg_string,
    MRB_ARGS_REQ(1)
  );

  mrb_define_class_method(
    mrb,
    binding_class,
    "get_arg_number",
    get_arg_number,
    MRB_ARGS_REQ(1)
  );


  mrb_define_class_method(
    mrb,
    binding_class,
    "get_arg_class_name",
    get_arg_class_name,
    MRB_ARGS_REQ(1)
  );


  mrb_define_class_method(
    mrb,
    binding_class,
    "get_arg_reference",
    get_arg_reference,
    MRB_ARGS_REQ(1)
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

  mrb_define_class_method(
    mrb,
    binding_class,
    "set_arg_number",
    set_arg_number,
    MRB_ARGS_REQ(2)
  );

  mrb_define_class_method(
    mrb,
    binding_class,
    "set_arg_value",
    set_arg_value,
    MRB_ARGS_REQ(2)
  );

  mrb_define_class_method(
    mrb,
    binding_class,
    "set_arg_callback",
    set_arg_callback,
    MRB_ARGS_REQ(2)
  );

  mrb_define_class_method(
    mrb,
    binding_class,
    "set_object_value_string",
    set_object_value_string,
    MRB_ARGS_REQ(3)
  );

  mrb_define_class_method(
    mrb,
    binding_class,
    "set_object_value_number",
    set_object_value_number,
    MRB_ARGS_REQ(3)
  );

  mrb_define_class_method(
    mrb,
    binding_class,
    "set_object_value",
    set_object_value,
    MRB_ARGS_REQ(3)
  );

  mrb_define_class_method(
    mrb,
    binding_class,
    "set_object_undefined",
    set_object_undefined,
    MRB_ARGS_REQ(2)
  );

  mrb_define_class_method(
    mrb,
    binding_class,
    "set_object_null",
    set_object_null,
    MRB_ARGS_REQ(2)
  );

  mrb_define_class_method(
    mrb,
    binding_class,
    "set_object_ruby_value",
    set_object_ruby_value,
    MRB_ARGS_REQ(3)
  );

  mrb_define_class_method(
    mrb,
    binding_class,
    "get_type_of",
    get_type_of,
    MRB_ARGS_REQ(1)
  );

  mrb_define_class_method(
    mrb,
    binding_class,
    "get_ruby_reference_id",
    get_ruby_reference_id,
    MRB_ARGS_REQ(1)
  );

  mrb_define_class_method(
    mrb,
    binding_class,
    "is_function_constructor",
    is_function_constructor,
    MRB_ARGS_REQ(1)
  );

  mrb_define_class_method(
    mrb,
    binding_class,
    "make_callback_reference",
    make_callback_reference,
    MRB_ARGS_REQ(1)
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

EXPORT void load_ruby(char* name) {
  load_file(name);
}

EXPORT void print_backtrace(char* msg) {
  mrb_exc_raise(mrb, mrb_exc_new_str(mrb, E_SCRIPT_ERROR, mrb_str_new_cstr(mrb, msg)));
  mrb_print_backtrace(mrb);
}

EXPORT char* get_ruby_reference_type(int ruby_reference_id) {
  mrb_value value;

  value = mrb_funcall(
    mrb,
    mrb_obj_value(external_references),
    "get_ruby_reference_type",
    1,
    mrb_int_value(mrb, ruby_reference_id)
  );

  if (mrb->exc) {
    mrb_print_error(mrb);
    mrb->exc = NULL;
  }

  return RSTRING_PTR(value);
}

EXPORT char* get_ruby_reference_property_type(char* prop_name, int ruby_reference_id) {
  mrb_value value;

  value = mrb_funcall(
    mrb,
    mrb_obj_value(external_references),
    "get_ruby_reference_property_type",
    2,
    mrb_str_new_cstr(mrb, prop_name),
    mrb_int_value(mrb, ruby_reference_id)
  );

  if (mrb->exc) {
    mrb_print_error(mrb);
    mrb->exc = NULL;
  }

  return RSTRING_PTR(value);
}

EXPORT double get_ruby_reference_number(char* prop_name, int ruby_reference_id) {
  mrb_float value;

  value = mrb_float(mrb_funcall(
    mrb,
    mrb_obj_value(external_references),
    "get_ruby_reference_number",
    2,
    mrb_str_new_cstr(mrb, prop_name),
    mrb_int_value(mrb, ruby_reference_id)
  ));

  if (mrb->exc) {
    mrb_print_error(mrb);
    mrb->exc = NULL;
  }

  return value;
}

EXPORT char* get_ruby_reference_string(char* prop_name, int ruby_reference_id) {
  mrb_value value;

  value = mrb_funcall(
    mrb,
    mrb_obj_value(external_references),
    "get_ruby_reference_string",
    2,
    mrb_str_new_cstr(mrb, prop_name),
    mrb_int_value(mrb, ruby_reference_id)
  );

  if (mrb->exc) {
    mrb_print_error(mrb);
    mrb->exc = NULL;
  }

  return RSTRING_PTR(value);
}

EXPORT int get_ruby_method_reference(char* prop_name, int ruby_reference_id) {
  mrb_value value;

  value = mrb_funcall(
    mrb,
    mrb_obj_value(external_references),
    "get_ruby_method_reference",
    2,
    mrb_str_new_cstr(mrb, prop_name),
    mrb_int_value(mrb, ruby_reference_id)
  );

  if (mrb->exc) {
    mrb_print_error(mrb);
    mrb->exc = NULL;
  }

  return mrb_integer(value);
}

EXPORT int get_ruby_iterator_reference(int ruby_reference_id) {
  mrb_value value;

  value = mrb_funcall(
    mrb,
    mrb_obj_value(external_references),
    "get_ruby_iterator_reference",
    1,
    mrb_int_value(mrb, ruby_reference_id)
  );

  if (mrb->exc) {
    mrb_print_error(mrb);
    mrb->exc = NULL;
  }

  return mrb_integer(value);
}

EXPORT int call_ruby_value_returning_reference(int ruby_reference_id) {
  mrb_value value;

  value = mrb_funcall(
    mrb,
    mrb_obj_value(external_references),
    "call_ruby_value_returning_reference",
    1,
    mrb_int_value(mrb, ruby_reference_id)
  );

  if (mrb->exc) {
    mrb_print_error(mrb);
    mrb->exc = NULL;
  }

  return mrb_integer(value);
}


EXPORT int load(char* main, char* config) {
  const char* class_name;
  mrb_define_global_const(mrb, "JSON_CONFIG", mrb_str_new_cstr(mrb, config));
  load_file("prism-ruby/prism.rb");
  struct RClass* prism_module = mrb_module_get(mrb, "Prism");

  external_references = mrb_class_get_under(mrb, prism_module, "ExternalReferences");
  load_file(main);

  return 0;
}

EXPORT char* render() {
  mrb_value result = mrb_funcall(mrb, app, "render", 0);
  if (mrb->exc) {
    mrb_print_error(mrb);
    mrb->exc = NULL;
  }
  return RSTRING_PTR(result);
}

EXPORT char* eval(char* input, int len) {
  mrb_int ai = mrb_gc_arena_save(mrb);
  mrb_value result = mrb_load_string_cxt(mrb, input, c);
  mrb_gc_arena_restore(mrb, ai);
  if (mrb->exc) {
    mrb_print_error(mrb);
    mrb->exc = NULL;
  }
  return RSTRING_PTR(mrb_obj_as_string(mrb, result));
}

EXPORT void dispatch(char* message) {
  mrb_value str = mrb_str_new_cstr(mrb, message);
  mrb_gc_register(mrb, str);
  mrb_funcall(mrb, app, "dispatch", 1, str);
  if (mrb->exc) {
    mrb_print_error(mrb);
    mrb->exc = NULL;
  }
  mrb_gc_unregister(mrb, str);
}

EXPORT void event(char* message, char* id) {
  mrb_value str = mrb_str_new_cstr(mrb, message);
  mrb_value str2 = mrb_str_new_cstr(mrb, id);
  mrb_funcall(mrb, app, "event", 2, str, str2);

  if (mrb->exc) {
    mrb_print_error(mrb);
    mrb->exc = NULL;
  }
}

EXPORT void handle_callback(int reference) {
  mrb_funcall(mrb, mrb_obj_value(external_references), "handle_callback", 1, mrb_int_value(mrb, reference));

  if (mrb->exc) {
    mrb_print_error(mrb);
    mrb->exc = NULL;
  }
}

EXPORT void cleanup_reference(int reference) {
  mrb_funcall(mrb, mrb_obj_value(external_references), "cleanup_reference", 1, mrb_int_value(mrb, reference));

  if (mrb->exc) {
    mrb_print_error(mrb);
    mrb->exc = NULL;
  }
}
