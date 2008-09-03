# encoding: utf-8
# 
# copyrigth (c) 2008 arton
#
require 'gettext'

module NLize
  GetText::bindtextdomain('rubymsg')
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
