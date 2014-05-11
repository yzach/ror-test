class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :set_locale_from_url

  def set_locale_from_url
    locale = [
        params['locale'],
        get_locale_from_http_accept_header,
        I18n.default_locale
    ].find &:present?
    I18n.locale = locale
  end

  def get_locale_from_http_accept_header
    # This implementation ignores quality and region specified by RFC2616
    # Accept-Language: da, en-gb;q=0.8, en;q=0.7
    # TODO: Replace with HttpAcceptLanguage gem

    # Extract two first letters of each acceptable locale

    return unless request.env['HTTP_ACCEPT_LANGUAGE']

    locales = request.env['HTTP_ACCEPT_LANGUAGE'].split(',').map { |locale| locale.strip[0..2].to_sym }
    # Select the best match
    (locales & I18n.available_locales).first
  end

  def url_for(options={})
    # Hack to automatically add current locale to urls

    if options.kind_of? Hash
      options = options.dup
      key = if options.has_key? 'locale'
        'locale'
      else
        :locale
      end
      options[key] = self.params['locale'] unless options[key]
    end
    super(options)
  end

  helper_method :url_for

  def authenticate_admin_user!
    authenticate_user!
    unless current_user.admin?
      flash[:error] = 'You are not admin'
      redirect_to root_path
    end
  end

  def current_admin_user
    current_user if current_user && current_user.admin?
  end
end
