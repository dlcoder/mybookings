class ResourceTypesExtensionsWrapper

  def self.call callback, booking
    extension_name = booking.resource_resource_type_extension
    extension = "ResourceTypesExtensions::#{extension_name}::Extension".constantize
    extension.send(callback, booking)
  end

end
