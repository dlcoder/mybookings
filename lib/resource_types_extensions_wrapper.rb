class ResourceTypesExtensionsWrapper

  def self.call extension, callback, booking
    extension = "ResourceTypesExtensions::#{extension}::Extension".constantize
    extension.send(callback, booking)
  end

end
