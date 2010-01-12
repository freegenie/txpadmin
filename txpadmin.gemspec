# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{txpadmin}
  s.version = "0.0.2"   
  s.required_rubygems_version = Gem::Requirement.new(">= 1.3") if s.respond_to? :required_rubygems_version=
  s.authors = ["Fabrizio Regini"]
  s.date = %q{2009-12-26}
  s.default_executable = %q{rg}
  s.description = %q{Textpattern admin tool.}
  s.email = %q{freegenie@gmail.com}
  s.executables = ["txpadmin"]
  s.extra_rdoc_files = [
    "README.markdown"
  ]
  s.files = [
    "README.markdown",
     "Rakefile",
     "bin/txpadmin",
     "lib/txp_admin.rb",
     "Rakefile",
     "txpadmin.gemspec"
  ]
  s.homepage = %q{http://github.com/freegenie/txpadmin}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{Txpadmin helps textpattern management from command line.}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3
    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end

