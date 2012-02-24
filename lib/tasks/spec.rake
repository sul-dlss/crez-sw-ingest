require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:rspec) do |spec|
  spec.rspec_opts = ["-c", "-f progress", "-r ./spec/spec_helper.rb"]
#  spec.pattern = FileList['spec/**/*_spec.rb']
  spec.pattern = 'spec/**/*_spec.rb'
end


