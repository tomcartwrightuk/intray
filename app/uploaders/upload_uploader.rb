# encoding: utf-8

class UploadUploader < CarrierWave::Uploader::Base

  # Include RMagick or ImageScience support:
  # include CarrierWave::RMagick
  # include CarrierWave::ImageScience
  CarrierWave.configure do |config|
    config.permissions = 0600
  end
  # Choose what kind of storage to use for this uploader:
  #storage :file
  storage :fog
#
  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
     "uploads/#{self.model.user.id}"
    #"uploads/test"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  # version :thumb do
  #   process :scale => [50, 50]
  # end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  # def extension_white_list
  #   %w(jpg jpeg gif png)
  # end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  #def filename
    #if original_filename
      #search_name = original_filename
      #version = self.model.user.resources.find_by_upload(search_name)
      #if version
        #version_update = version.version_no + 1
        #version.update_attributes(:version_no => version_update)
        #self.model.update_version_no(version.id, version_update)
        #current_filename = "#{file.basename}_copy_#{version_update.to_s}.#{file.extension}"
        #@name ||= "#{current_filename}"
      #end
    #end
  #end

  

end
