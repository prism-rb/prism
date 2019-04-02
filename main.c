#include <stdarg.h>
#include <mruby.h>
#include <mruby/irep.h>
#include "test.c"

int
main(void)
{
  mrb_state *mrb = mrb_open();
  if (!mrb) { /* handle error */ }
  mrb_load_irep(mrb, test);
  mrb_close(mrb);
  return 0;
}
