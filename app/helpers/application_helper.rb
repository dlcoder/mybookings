module ApplicationHelper

  def title title=t('.title')
    title_for_html title
    title_for_page title
  end

  def title_for_html title=t('.title')
    content_for :html_title, "#{ title } - #{ t('app_name') }"
  end

  def title_for_page title=t('.title')
    content_for :page_title, title
  end

end
