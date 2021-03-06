Gem::Specification.new do |s|
  s.name = %q{nlize}
  s.version = "0.0.2"
  s.date = %q{2008-09-04}
  s.summary = %q{TODO:}
  s.email = %q{artonx@gmail.com}
  s.homepage = %q{http://github.com/arton/nlize/}
  s.description = %q{native languagized ruby error messages}
  s.required_ruby_version = Gem::Version::Requirement.new(">= 1.8.7")
  s.authors = ["arton"]
  s.files = ["lib/nlize.rb", "po/rubymsg.pot", "po/ja/rubymsg.po", "data/locale/ja/LC_MESSAGES/rubymsg.mo", "ext/cnlize.c", "ext/depend", "test/test.rb", "ChangeLog", "ext/extconf.rb"]
  s.test_files = ["test/test.rb"]
  s.extensions = ["ext/extconf.rb"]
  s.requirements = ["x86 cpu platform"]
  s.add_dependency(%q<gettext>, [">= 1.92.0"])
end
