class EditsController < ApplicationController
  before_action :authenticate_user!

  def new
    translation = current_translation
    text = params[:text] || translation.text
    @story = translation.story
    @edit = translation.edits.build original_text: text, suggested_text: text

    opts = {}
    opts[:layout] = nil if request.xhr?

    render 'edit_form', opts
  end

  def create
    translation = current_translation
    edit = translation.edits.build edit_params
    edit.status = 'new'

    if edit.save
      redirect_to request.referrer, notice: t(:edit_created)
    else
      opts = {}
      opts[:layout] = nil if request.xhr?

      render 'edit_form', opts
    end
  end

  def current_translation
    StoryTranslation.joins(:language).where(
        story_id: params[:story_id],
        languages: {code: I18n.locale.to_s}
    ).first
  end

private

  def edit_params
    params.require(:edit).permit(:original_text, :suggested_text)
  end

end
