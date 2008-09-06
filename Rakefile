require 'rubygems'
require 'rake/gempackagetask'
require 'fileutils'

def read_version
  m = /\#define\s+NLIZE\_VERSION +"(\d+\.\d+\.\d+)"/.match(IO.read('ext/cnlize.c'))
  return m[1] if m
end

task :default => [:init_spec, :package]

task :test do
  if ENV['RUBYLIB']
    ENV['RUBYLIB'] = File.expand_path(lib) + File::PATH_SEPARATOR + ENV['RUBYLIB']
  else
    ENV['RUBYLIB'] = File.expand_path(lib)
  end
  Dir.chdir test
  system 'ruby test.rb'
end

task :init_spec do
  spec = Gem::Specification.new do |s|
    s.authors = 'arton'
    s.add_dependency('gettext', '>= 1.92.0')
    s.email = 'artonx@gmail.com'
    s.platform = Gem::Platform::RUBY
    if /mswin32|mingw/ =~ RUBY_PLATFORM
      s.platform = Gem::Platform::CURRENT
    else
      s.platform = Gem::Platform::RUBY
      s.extensions << 'ext/extconf.rb'
    end
    s.required_ruby_version = ">= 1.8.7"
    s.summary = 'TODO: '
    s.name = 'nlize'
    s.homepage = %q{http://github.com/arton/nlize/}
    s.version = read_version
    s.requirements << 'none'
    s.require_path = 'lib'
    files = FileList['lib/**/*.rb', 'po/**/*.po*', 'data/**/*.mo', 'ext/*.c', 'ext/*.h', 'ext/depend',
                     'test/*.rb', '*.txt', 'ChangeLog']
    s.has_rdoc = false
    if /mswin32/ =~ RUBY_PLATFORM
      FileUtils.cp 'ext/cnlize.so', 'lib/cnlize.so'
      files << "lib/cnlize.so"
      s.requirements << ' VC6 version of Ruby'
    end
    s.files = files
    s.test_file = 'test/test.rb'
    s.description = 'native languagized ruby error messages'
  end

  Rake::GemPackageTask.new(spec) do |pkg|
    pkg.gem_spec = spec
    pkg.need_zip = false
    pkg.need_tar = false
  end
end

desc "rake make_po RUBYDIR=[path to ruby's src dir]"
task :make_pot do
  require 'tool/extmsg'
  unless ENV['RUBYDIR']
    puts 'must specify RUBYDIR'
  else
    Dir.mkdir 'po' unless File.exist?('po')
    File.open('po/rubymsg.pot', 'w') do |f|
      NLize.extract ENV['RUBYDIR'], f
    end
  end
end

task :init_po do
  unless ENV['LANG']
    puts 'must specify LANG'
  else
    lang = ENV['LANG'][0..1]
    Dir.mkdir File.join('po', lang) unless File.exist?(File.join('po', lang))
    FileUtils.cp 'po/rubymsg.pot', File.join('po', lang, 'rubymsg.po')
    puts "please translate #{File.join('po', lang, 'rubymsg.po')}"
  end
end

task :update_po do
  require 'gettext/utils'
  unless ENV['LANG']
    puts 'must specify LANG'
  else
    lang = ENV['LANG'][0..1]
    GetText.msgmerge(File.join('po', lang, 'rubymsg.po'), 'po/rubymsg.pot', 'ruby 1.8.7-p72')
  end
end  

task :make_mo do
  require 'gettext/utils'
  GetText.create_mofiles(true, 'po', 'data/locale')
end
