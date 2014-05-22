class TranslationModeController < ApplicationController
  before_filter :authenticate_corrector!

  def index
    @translations = StoryTranslation.joins(:complaints)
        .group(:translation_id).where(complaints: { status: 'new' })
  end

  def show
    @translation = StoryTranslation.joins(:complaints).find(params[:id])
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
