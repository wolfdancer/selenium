$:.unshift File.dirname(__FILE__)

require 'rubygems'
Gem::manage_gems
require 'rake'
require 'spec/rake/spectask'
require 'rake/gempackagetask'
require 'rake/rdoctask'
require 'rcov/rcovtask'
require 'specs'

rcov_dir = SITE_SPEC.output_dir.dir('rcov')
rspec_dir = SITE_SPEC.output_dir.dir('rspec')

task :init do
  rcov_dir.mkdirs
  rspec_dir.mkdirs
end

#desc "Run all specifications"
Spec::Rake::SpecTask.new(:coverage) do |t|
  t.spec_files = FileList['test/**/tc_*.rb']
  t.rcov = true
  t.rcov_dir = rcov_dir.path
  t.spec_opts = ["--format", "html", "--diff"]
  t.out = rspec_dir.file('index.html').path
  t.fail_on_error = false
end

Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.main = "README"
  rdoc.rdoc_files.include("README", "lib/**/*.rb").exclude("lib/buildmaster/site/templatelets/*.rb")
  rdoc.options << "--all"
  rdoc.rdoc_dir = SITE_SPEC.output_dir.dir('rdoc').path.to_s
end

task :default => [:coverage, :build_site, :rdoc, :package]
task :coverage => [:init]

# ??? if we use the rakt gem task, it will somehow be built multiple times and fail???
task :package do
  Gem::manage_gems
  Gem::Builder.new(SPEC).build
end

task :build_site do
  BuildMaster::Site.new(SITE_SPEC).build
end

task :publish_site do
  svn = BuildMaster::SvnDriver.from_path(BuildMaster::Cotta.new.file(__FILE__).parent)
  output_dir = SITE.output_dir
  raise 'output dir needs to be called the same as the project name for one copy action to work' unless output_dir.name == 'buildmaster'
  BuildMaster::PscpDriver.new("#{svn.user}@buildmaster.rubyforge.org").copy(output_dir.path, '/var/www/gforge-projects')
end

task :test_site do
  BuildMaster::Site.new(SITE_SPEC).test
end

task :serve do
  BuildMaster::Site.new(SITE_SPEC).server
end

task :setup_site do
  BuildMaster::Site.setup(SITE_SPEC)
end
