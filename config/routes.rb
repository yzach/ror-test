RorTest::Application.routes.draw do

  ActiveAdmin.routes(self)

  available_locales_regexp = Regexp.union(*I18n.available_locales.map(&:to_s))

  scope '(:locale)', locale: available_locales_regexp, defaults: { locale: nil } do
    devise_for :users

    resources :stories do
      member do
        get 'untranslated' => 'stories#show_untranslated'
      end
      resource :complaints, shallow: true
    end

    get 'my-stories' => 'stories#my_stories', as: 'my_stories'

    resources 'translation-mode', only: [:index, :show, :update], as: :translation_mode, controller: :translation_mode
  end

  get '/:locale' => 'stories#index', locale: available_locales_regexp
  root 'stories#index'

end
