desc 'make it work'
task :purge_followers => :environment do
  FluxFollower.purge
  puts 'still working'
end
