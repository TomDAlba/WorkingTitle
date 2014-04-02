CarrierWave.configure do |config|
     config.s3_access_key_id = ""
     config.s3_secret_access_key = ""
     config.s3_bucket = ""
end


if Rack::Utils.respond_to?("key_space_limit=")
  Rack::Utils.key_space_limit = 262144
end
