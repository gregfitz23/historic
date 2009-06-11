# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{historic}
  s.version = "0.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Greg Fitzgerald"]
  s.date = %q{2009-06-11}
  s.email = %q{greg_fitz@yahoo.com}
  s.extra_rdoc_files = [
    "LICENSE",
    "README.rdoc"
  ]
  s.files = [
    "LICENSE",
    "README.rdoc",
    "Rakefile",
    "VERSION.yml",
    "lib/historic.rb",
    "lib/historic/historic.rb",
    "lib/historic/historic_record.rb",
    "test/historic_item.rb",
    "test/historic_item_history.rb",
    "test/historic_test.rb",
    "test/test_helper.rb"
  ]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/gregfitz23/historic}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{TODO}
  s.test_files = [
    "test/historic_item.rb",
    "test/historic_item_history.rb",
    "test/historic_test.rb",
    "test/test_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
