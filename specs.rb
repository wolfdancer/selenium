$:.unshift File.dirname(__FILE__)

require 'rubygems'
Gem::manage_gems
require 'rake'
require 'buildmaster/project'
require 'buildmaster/project/ruby_forge_project'
require 'buildmaster/site'
require 'buildmaster/cotta'

VERSION_NUMBER = BuildMaster::VersionNumberFile.new(BuildMaster::Cotta.parent_of(__FILE__).file('lib/selenium/version'))
PROJECT = BuildMaster::RubyForgeProject.new('selenium', '2789')

SITE_SPEC = BuildMaster::SiteSpec.new(__FILE__) do |spec|
  spec.content_dir = 'site'
  spec.output_dir = 'build/website/selenium'
  spec.template_file = 'site_template.html'
  spec.add_property('release', '1.0.1')
  spec.add_property('prerelease', 'n/a')
  spec.add_property('snapshot', VERSION_NUMBER.version_number)
  spec.add_property('source_url', PROJECT.source_repository)
  spec.add_property('download_url', PROJECT.release_download_url)
end

SPEC = Gem::Specification.new do |spec|
  spec.name = 'Selenium'
  spec.version = VERSION_NUMBER.version_number
  spec.author = 'Shane Duan'
  spec.email = 'selenium@gmail.com'
  spec.homepage = 'http://selenium.rubyforge.org/'
  spec.platform = Gem::Platform::RUBY
  spec.summary = 'A project that wraps selenium API into object-oriented testing style and packages it into a RubyGem.'
  spec.files = FileList["{bin,docs,lib,spec}/**/*"].exclude("rdoc").to_a
  spec.require_path = 'lib'
  spec.autorequire = 'selenium'
  spec.has_rdoc = true
  spec.extra_rdoc_files = ["README"]
  spec.bindir = 'bin'
  spec.executables = ['selenium']
  spec.default_executable = 'selenium'
  spec.rubyforge_project = "selenium"
end