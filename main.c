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

int
main(int argc, const char * argv[])
{
  mrb = mrb_open();

  if (!mrb) { /* handle error */ }

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
