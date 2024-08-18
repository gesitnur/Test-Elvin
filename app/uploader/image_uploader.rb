# frozen_string_literal: true

class ImageUploader < Shrine
  plugin :validation_helpers
  plugin :pretty_location

  Attacher.derivatives_processor do |original|
    if file.metadata['mime_type'].include?('image')
      magick = ImageProcessing::MiniMagick.source(original)
      {
        large: magick.resize_to_limit!(800, 800),
        medium: magick.resize_to_limit!(500, 500),
        small: magick.resize_to_limit!(300, 300)
      }
    end
  end

  Attacher.validate do
    validate_mime_type %w[image/jpeg image/png image/webp]
  end

  # def generate_location(io, context = {})
  #   # returns URL to the remote file, can accept URL options
  #   record = context[:record]
  #   base_path = "#{Rails.root}/public" if Rails.env.development?
  #   base_path = '/home/deploy/tvms-web/shared/public' unless Rails.env.development?

  #   "#{base_path}/uploads/#{Rails.env}/avatars/#{record.class.name.underscore.pluralize}/#{record.id}/#{object_id}"
  # end

  class Attacher
    def promote(*)
      create_derivatives || {}
      super
    end
  end
end
