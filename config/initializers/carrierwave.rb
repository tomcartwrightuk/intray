Fog.credentials_path = Rails.root.join('config/fog_credentials.yml')

CarrierWave.configure do |config|
  config.fog_credentials = {
      :provider => 'AWS',
      :aws_access_key_id => 'AKIAINKSY6NLOXF73YXQ',
      :aws_secret_access_key => '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',
  }
  config.fog_directory  = 'intray-file-uploads'                     # required
  config.fog_host       = 'https://localhost:3000'            # optional, defaults to nil
  config.fog_public     = false                                   # optional, defaults to true
  config.fog_attributes = {'Cache-Control'=>'max-age=100'}  # optional, defaults to {}
end
