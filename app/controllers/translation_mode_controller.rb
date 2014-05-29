class TranslationModeController < ApplicationController
  before_filter :authenticate_corrector!

  def index
    translations = StoryTranslation.distinct.joins(:complaints)
        .where(complaints: { status: 'new' })

    # My only hope is that there won't be lots of complaints
    # TODO: Rewrite as a query. Might require scheme change
    @translations = translations.select do |translation|
      current_user.can_translate? translation
    end
  end

  def show
    @translation = StoryTranslation.includes(complaints: :comments).find(params[:id])
  end

  def update
    @translation = StoryTranslation.find(params[:id])

    if @translation.update translation_params
      redirect_to translation_mode_index_path, notice: t('translation_mode.messages.saved')
    else
      render 'show'
    end
  end

private
  def authenticate_corrector!
    authenticate_user!
    redirect_to root_path, alert: t(:access_denied) unless can? :translation_mode, StoryTranslation
  end

  def translation_params
    params.require(:story_translation).permit(:text ,complaints_attributes: [:id, :status])
  end
end
