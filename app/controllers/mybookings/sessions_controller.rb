module Mybookings
  class SessionsController < Devise::SessionsController
    def destroy
      saml_uid = session['saml_uid']
      super do
        session['saml_uid'] = saml_uid
      end
    end

    def after_sign_out_path_for resource
      if session['saml_uid'] && Devise::omniauth_configs[:saml].options[:idp_slo_target_url]
        session.delete('saml_uid')
        user_saml_omniauth_authorize_path + '/spslo'
      else
        super
      end
    end
  end
end
