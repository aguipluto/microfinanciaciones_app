unless Rails.env.production?
  ENV['AWS_BUCKET']   = 'microfinanciacionesapp-images'
  ENV['AWS_ACCESS_KEY_ID']   = 'AKIAJ4KGSWA2R45FBAWA'
  ENV['AWS_SECRET_ACCESS_KEY'] = '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'
end
