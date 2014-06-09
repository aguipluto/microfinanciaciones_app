CarrierWave.configure do |config|
  config.fog_credentials = {
      :provider               => 'AWS',                        # required
      :aws_access_key_id      => ENV['AWS_ACC'],                        # required
      :aws_secret_access_key  => ENV['AWS_SEC'],                        # required
  }
  config.fog_directory  = 'name_of_bucket'                     # required
end