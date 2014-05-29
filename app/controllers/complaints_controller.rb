class ComplaintsController < ApplicationController
  before_action :authenticate_user!

  def new
    translation = current_translation
    text = params[:text].present? ? params[:text] : translation.text
    @story = translation.story
    @complaint = translation.complaints.build text: text

    opts = {}
    opts[:layout] = nil if request.xhr?

    render 'complaint_form', opts
  end

  def create
    translation = current_translation
    final_params = edit_params.deep_merge(
        status: 'new', user_id: current_user.id,
        :comments_attributes => {'0' => {user_id: current_user.id}}
    )
    complaint = translation.complaints.build final_params

    if complaint.save
      redirect_to request.referrer, notice: t('complaints.messages.accepted')
    else
      opts = {}
      opts[:layout] = nil if request.xhr?

      render 'complaint_form', opts
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
    params.require(:complaint).permit(:text, comments_attributes: [:text])
  end
end
