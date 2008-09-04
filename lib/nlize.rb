# encoding: utf-8
# 
# copyrigth (c) 2008 arton
#
begin
  require 'gettext'
rescue LoadError
  require 'rubygems'
  require 'gettext'
end  

module NLize
  opt = {}
  if  __FILE__ =~ %r|\A(.+ruby/gems/1\.8/gems/nlize.+)/lib/nlize.rb|
    opt[:path] = "#{$1}/data/locale"
  end
  GetText::bindtextdomain('rubymsg', opt)
  def self.translate(msg)
    r = GetText::_(msg)
    if r == msg
      if /.+Error: (.+)\Z/ =~ msg
        r = GetText::_($1)
      end
    end
    r
  end
end

require 'cnlize'
