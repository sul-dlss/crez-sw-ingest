require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:rspec) do |spec|
  spec.rspec_opts = ["-c", "-f progress", "-r ./spec/spec_helper.rb"]
end

desc "Run all specs, with jetty instance running"
task :rspec_wrapped => ['setup_jetty'] do
  jetty_dir = File.expand_path(File.dirname(__FILE__) + '../../../solrmarc-sw/test/jetty')
  require 'jettywrapper'
  jetty_params = Jettywrapper.load_config.merge({
    :jetty_home => jetty_dir,
    :solr_home => jetty_dir + '/solr',
    :java_opts => "-Dsolr.data.dir=" + jetty_dir + "/solr/data",
    :startup_wait => 45
  })
  error = Jettywrapper.wrap(jetty_params) do 
    Rake::Task['rspec'].invoke
  end
  raise "TEST FAILURES: #{error}" if error
end
