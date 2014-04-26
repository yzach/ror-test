class StoriesController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    # Only stories that have translation
    @stories = Story.joins(:translations).joins(:languages)
                    .where(languages: {code: I18n.locale})
                    .includes(:translations)
  end

  def create
    @story = current_user.stories.build story_params

    if @story.save
      redirect_to @story, notice: 'Story has been created'
    else
      render 'story_form'
    end
  end

  def new
    @story = Story.new
    @story.translations.build
    render 'story_form'
  end

  def story_form
    @story = users_story
  end

  def show
    @story = Story.find params[:id]
  end

  def edit
    @story = users_story
    render 'story_form'
  end

  def update
    @story = users_story

    if @story.update_attributes story_params
      @story.save
      redirect_to @story, notice: 'Story has been updated'
    else
      render 'story_form'
    end
  end

  def destroy
    @story = users_story
    @story.delete

    # For some reason has no effect when appended to #redirect_to
    flash[:notice] = 'Story has been removed'

    redirect_to action: 'my_stories'
  end

  def my_stories
    @stories = current_user.stories
  end

private
  def story_params
    params.require(:story).permit(translations_attributes: [:id, :title, :text, :language_id])
  end

  def users_story
    current_user.stories.find params[:id]
  end
end
