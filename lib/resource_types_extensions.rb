class ResourceTypesExtensions

  def self.call extension, callback, booking
    extension = "ResourceTypesExtensions::#{extension}".constantize
    extension.send(callback, booking)
  end

end
