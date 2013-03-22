require 'open-uri'

namespace :geoip do
  desc 'Downloads the latest GeoLite City database from MaxMind and decompress into public folder'
  task :download do
    # download the latest GeoLite City database and decompress
    open("#{Rails.root}/public/GeoLiteCity.dat.gz", 'wb') do |file|
      file << open('http://geolite.maxmind.com/download/geoip/database/GeoLiteCity.dat.gz').read
    end
    `gunzip #{Rails.root}/public/GeoLiteCity.dat.gz`    
  end
end

Rake::Task['assets:precompile'].enhance do
  Rake::Task['geoip:download'].invoke
end
