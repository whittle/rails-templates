gem 'cucumber', :version => '0.3.11'
gem 'rspec-rails', :lib => false, :version => '1.2.7.1'
gem 'rspec', :lib => false, :version => '1.2.8'
gem 'webrat', :version => '0.4.4'

git :submodule => 'add git://github.com/flogic/object_daddy.git vendor/plugins/object_daddy'

generate 'cucumber', '--spork'
generate 'rspec'
