file = File.join(File.dirname(__FILE__), 'lib')

require 'rubygems'
Gem::manage_gems
require 'rake'
require 'spec/rake/spectask'
require 'rake/gempackagetask'
require 'rake/rdoctask'
require 'rcov/rcovtask'
gem 'BuildMaster', '>=1.1.12'
require 'specs'
gem 'rr'
require 'buildmaster/project/server_manager'
require file + '/selenium'

rcov_dir = SITE_SPEC.output_dir.dir('rcov')
rspec_dir = SITE_SPEC.output_dir.dir('rspec')

task :init do
  rcov_dir.mkdirs
  rspec_dir.mkdirs
end

desc "Run all specifications providing test coverage metrics"
Spec::Rake::SpecTask.new(:coverage) do |t|
  t.spec_files = FileList['spec/**/tc_*.rb']
  t.rcov = true
  t.rcov_dir = rcov_dir.path
  t.spec_opts = ["--format", "html:#{rspec_dir.file('index.html').path}", "--diff"]
  t.fail_on_error = false
end

Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.main = "README"
  rdoc.rdoc_files.include("README", "lib/**/*.rb")
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

task :local_install do
  gem_file = SPEC.full_name + ".gem"
  puts "Insalling #{gem_file}..."
  Gem::Installer.new(gem_file).install
end

task :build_site do
  BuildMaster::Site.new(SITE_SPEC).build
end

task :publish_site do
  username = 'wolfdancer'
  output_dir = SITE_SPEC.output_dir
  raise 'output dir needs to be called the same as the project name for one copy action to work' unless output_dir.name == 'selenium'
  BuildMaster::PscpDriver.new("#{username}@selenium.rubyforge.org").copy(output_dir.path, '/var/www/gforge-projects')
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

task :selenium do
  server = Selenium::SeleniumServer.new(BuildMaster::Cotta.new, 4444)
  server.start
end
