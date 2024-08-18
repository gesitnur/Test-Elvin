require 'shrine'
require 'shrine/storage/file_system'

Shrine.storages = {
  cache: Shrine::Storage::FileSystem.new('public', prefix: 'uploads/cache'), # temporary    cache: Shrine::Storage::Cloudinary.new(prefix: 'cache'), # for direct uploads
  store: Shrine::Storage::FileSystem.new('public', prefix: 'uploads') # permanent    store: Shrine::Storage::Cloudinary.new,
}

Shrine.plugin :activerecord           # loads Active Record integration
Shrine.plugin :cached_attachment_data # enables retaining cached file across form redisplays
Shrine.plugin :derivatives
Shrine.plugin :restore_cached_data    # extracts metadata for assigned cached files
Shrine.plugin :determine_mime_type
Shrine.plugin :data_uri
Shrine.plugin :remove_attachment
