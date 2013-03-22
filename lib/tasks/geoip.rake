require 'open-uri'

namespace :geoip do
  desc 'Downloads the latest GeoLite City database from MaxMind and decompress into public folder'
  task :download do
    # download the latest GeoLite City database and decompress
    print "Downloading latest GeoLiteCity.dat.gz..."
    open("#{Rails.root}/public/GeoLiteCity.dat.gz", 'wb') do |file|
      file << open('http://geolite.maxmind.com/download/geoip/database/GeoLiteCity.dat.gz').read
    end
    print "Decompressing GeoLiteCity.dat.gz..."
    `gunzip #{Rails.root}/public/GeoLiteCity.dat.gz`
    print "Done preparing GeoLiteCity.dat.gz."
  end
end

if Rake::Task.task_defined?("assets:precompile:nondigest")
  Rake::Task["assets:precompile:nondigest"].enhance do
    Rake::Task["geoip:download"].invoke
  end
else
  Rake::Task["assets:precompile"].enhance do
    # rails 3.1.1 will clear out Rails.application.config if the env vars
    # RAILS_GROUP and RAILS_ENV are not defined. We need to reload the
    # assets environment in this case.
    # Rake::Task["assets:environment"].invoke if Rake::Task.task_defined?("assets:environment")
    Rake::Task["geoip:download"].invoke
  end
end
