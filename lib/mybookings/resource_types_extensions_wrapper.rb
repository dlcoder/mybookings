class ResourceTypesExtensionsWrapper
  def self.call callback, event
    extension_name = event.resource_resource_type_extension
    extension = "ResourceTypesExtensions::#{extension_name}::Extension".constantize
    extension.send(callback, event)
  end
end
