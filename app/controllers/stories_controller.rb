class StoriesController < ApplicationController
  before_action :authenticate_user!
  skip_after_action :authenticate_user!, only: [:index, :show]

  def index
    @stories = Story.all
  end

  def create
    @story = Story.new story_params
    @story.update_attributes user: current_user

    if @story.save
      redirect_to @story
    else
      render 'story_form'
    end
  end

  def new
    @story = Story.new
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
      redirect_to @story
    else
      render 'story_form'
    end
  end

  def destroy
    @story = users_story
    @story.delete

    redirect_to action: 'my_stories'
  end

  def my_stories
    @stories = current_user.stories
  end

private
  def story_params
    params.require(:story).permit(:title, :text)
  end

  def users_story
    Story.find_by! id: params[:id], user: current_user
  end
end
