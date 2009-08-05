test_gems = <<CODE

config.gem 'rspec', :lib => false, :version => '>=1.2.8'
config.gem 'rspec-rails', :lib => false, :version => '>=1.2.7.1'
config.gem 'cucumber', :version => '>=0.3.93'
config.gem 'webrat', :version => '>=0.4.4'
config.gem 'spork', :lib => false, :version => '>=0.5.7'
config.gem 'thoughtbot-factory_girl', :lib => 'factory_girl', :source => 'http://gems.github.com'
CODE
run "echo \"#{test_gems}\" >> config/environments/test.rb"
rake 'gems:install', :env => 'test', :sudo => true
generate 'cucumber', '--spork'
generate 'rspec'
run 'spork --bootstrap'
run 'echo "--drb" >> spec/spec.opts'
