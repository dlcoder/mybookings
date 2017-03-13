class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value.nil? or value.empty?

    unless value =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
      record.errors[attribute] << (options[:message] || I18n.t('.activerecord.errors.models.invalid_email'))
    end
  end
end
