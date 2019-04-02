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
#include "test.c"

struct _args {
  FILE *rfp;
  mrb_bool verbose      : 1;
  mrb_bool debug        : 1;
  int argc;
  char** argv;
  int libc;
  char **libv;
};

int
main(int argc, const char * argv[])
{
  int n;
  int i;
  mrb_value ARGV;
  mrb_state *mrb = mrb_open();

  if (!mrb) { /* handle error */ }

  ARGV = mrb_ary_new_capa(mrb, argc);
  for (i = 0; i < argc; i++) {
    char* utf8 = mrb_utf8_from_locale(argv[i], -1);
    if (utf8) {
      mrb_ary_push(mrb, ARGV, mrb_str_new_cstr(mrb, utf8));
      mrb_utf8_free(utf8);
    }
  }
  mrb_define_global_const(mrb, "ARGV", ARGV);

  mrb_load_irep(mrb, test);
  mrb_close(mrb);
  return 0;
}
