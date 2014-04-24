module ApplicationHelper
  def rtl?
    [:he].include? I18n.locale
  end
end
