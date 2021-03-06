#!/usr/bin/env ruby
# encodng: utf-8
#
# Fair License
# 
# Copyright (c) 2008 arton
#
# Usage of the works is permitted provided that this
# instrument is retained with the works, so that any entity
# that uses the works is notified of this instrument.
#
# DISCLAIMER: THE WORKS ARE WITHOUT WARRANTY.
#

require 'tempfile'
begin
  require 'gettext'
rescue LoadError
  require 'rubygems'
  require 'gettext'
end
require 'gettext/rgettext'

module NLize
  ERRMSG = [
            /rb_.+_error\(.*(\".+\")/,
            /rb_raise\(.+(\".+\").*\)/,
            /rb_bug\(\s*(\".+\").*\)/,            
            /format\s*\=\s*(\".+\")\s*;/,
            /yyerror\s*\(.*(\".+\").*\)\s*;/,
            /const yy.*expect.*\[\]\s*\=\s*(\".+\")\s*;/            
           ]
  def self.extract_from_c(dir, tmpf)
    Dir.foreach(dir) do |file|
      next if /^\./ =~ file 
      if File.extname(file) == '.c'
        i = 1
        File.open(File.expand_path(file, dir), 'r').each_line do |line|
          ERRMSG.each do |re|
            if re =~ line
              tmpf.puts "# #{file} line:#{i}"
              tmpf.puts "s = _(#{$1.gsub("\\", "\\\\\\")})"
              break
            end
          end
          i += 1
        end.close
      elsif File.directory?(file)
        extract_from_c File.join(dir, file), tmpf
      end
    end
  end

  def self.extract(dir, out = $stdout)
    tmpf = Tempfile.new('extmsg')
    extract_from_c dir, tmpf
    tmpf.close

    GetText.rgettext(tmpf.path, out)
    tmpf.open
    tmpf.close(true)
  end
end

if $0 == __FILE__
  if ARGV.size == 0
    puts 'usage: ruby extmsg.rb src-path'
    exit 1
  else
    NLize.extract ARGV[0]
  end
end

