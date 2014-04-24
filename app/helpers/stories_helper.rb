require 'bing_translator'

module StoriesHelper
  def auto_translate text, to=nil
    to = to || I18n.locale
    translator.translate(text, to: to)
  end

  def translator
    return @translator if @translator

    client_id = 'translation-service'
    client_secret = '+2r+EgXQVzg3TrR3kj00qES1wWSvFn9uR5FM3M8dJPE='
    azure_secret = 'yTgXjhgmC1cgAn4y7QjIemScvfpUgfF+W6Kb4ntM5Co'

    @translator = BingTranslator.new(client_id, client_secret, false, azure_secret)
  end
end
