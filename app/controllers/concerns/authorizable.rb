module Authorizable

  extend ActiveSupport::Concern

  included do
    before_action :authorize!
  end

  private

  def authorize!
    redirect_to (request.referrer || root_path), alert: t('not_authorized') unless @authorized
  end

end
