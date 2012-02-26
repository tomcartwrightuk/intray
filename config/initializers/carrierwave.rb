CarrierWave.configure do |config|
  Fog.credentials_path = Rails.root.join('config/fog_credentials.yml')
  config.fog_directory  = 'intray-file-uploads'                     # required
  config.fog_host       = 'https://localhost:3000'            # optional, defaults to nil
  config.fog_public     = false                                   # optional, defaults to true
  config.fog_attributes = {'Cache-Control'=>'max-age=100'}  # optional, defaults to {}
end
