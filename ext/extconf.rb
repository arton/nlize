require 'mkmf'
def create_cnlize_makefile
  $defs << "-DRUBY_ERRINFO=ruby_errinfo"
  have_header("sys/mman.h")
  have_func("vsnprintf_l")
  create_header
  create_makefile('cnlize')
end
create_cnlize_makefile
