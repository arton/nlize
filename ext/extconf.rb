require 'mkmf'
def create_cnlize_makefile
  $defs << "-DRUBY_ERRINFO=ruby_errinfo"
  create_header
  create_makefile('cnlize')
end
create_cnlize_makefile
