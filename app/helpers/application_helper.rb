module ApplicationHelper

  def body_classes
    'homepage' if current_page?(root_url)
  end

  def show_user_account_info_if_logged_in user
    unless user.nil? || user.id.nil?
      user_email_link_li = content_tag(:li, link_to(t('.you_are_logged_in_as', email: user.email), '#'))
      user_sign_out_link_li = content_tag(:li, link_to(t('.sign_out'), destroy_user_session_path, method: :delete))
      "#{user_email_link_li} #{user_sign_out_link_li}".html_safe
    end
  end

end
