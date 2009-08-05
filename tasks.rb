rakefile 'cache.rake' do
  <<-'TASK'
namespace :cache do
	desc 'Clear the cache. Useful for implementations using memcached. '
	task :clear => :environment do
		Rails.cache.clear
	end
end
  TASK
end

rakefile 'restart.rake' do
  <<-'TASK'
desc 'Restarts passenger instance, optionally with DEBUG. Once a debugger statement is reached, connect with "rdebug -c".'
task :restart do
	system('touch tmp/debug.txt') if ENV['DEBUG'] == 'true'
	system('touch tmp/restart.txt')
end
  TASK
end

rakefile 'validate.rake' do
  <<-'TASK'
# Stolen shamelessly from http://blog.hasmanythrough.com/2006/8/27/validate-all-your-records
namespace :db do
  desc "Run model validations on all model records in database"
  task :validate_models => :environment do
    puts "-- records - model --"
    Dir.glob(RAILS_ROOT + '/app/models/**/*.rb').each { |file| require file }
    Object.subclasses_of(ActiveRecord::Base).select { |c| c.base_class == c}.sort_by(&:name).each do |klass|
      total = klass.count
      printf "%10d - %s\n", total, klass.name
      chunk_size = 1000
      (total / chunk_size + 1).times do |i|
        chunk = klass.find(:all, :offset => (i * chunk_size), :limit => chunk_size)
        chunk.reject(&:valid?).each do |record|
          puts "#{record.class}: id=#{record.id}"
          p record.errors.full_messages
          puts
        end rescue nil
      end
    end
  end
end
  TASK
end

rakefile 'runcoderun.rake' do
	<<-'TASK'
desc 'Comprehensive (and very pretty) test output for runcoderun use.'
task :runcoderun do
	puts <<-EOS
========
Features
========

	EOS
	ENV['CUCUMBER_OPTS'] = '--profile default'
	verbose(false) { Rake::Task['features'].invoke }
	puts <<-EOS

=====
Specs
=====

	EOS
	ENV['SPEC_OPTS'] = '--format nested'
	Rake::Task['spec'].invoke
end
	TASK
end
