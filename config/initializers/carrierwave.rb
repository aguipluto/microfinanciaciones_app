CarrierWave.configure do |config|
  config.fog_credentials = {
      :provider               => 'AWS',                        # required
      :aws_access_key_id      => 'AKIAJCQQWYW6MBDA2AXA',                        # required
      :aws_secret_access_key  => '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',                        # required
  }
  config.fog_directory  = 'microfinanciacionesapp-images'                     # required

end