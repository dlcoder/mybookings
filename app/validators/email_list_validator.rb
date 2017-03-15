class EmailListValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value.nil? or value.empty?

    value.each do |email|
      next if /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i.match(email)
      record.errors[attribute] << (options[:message] || I18n.t('.activerecord.errors.models.invalid_email_list'))
      return
    end
  end
end
