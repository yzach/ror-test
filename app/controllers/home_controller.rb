class HomeController < ApplicationController
  def index
    @stories = Story.all
  end

  def my_stories
    authenticate_user!
    @stories = current_user.stories
  end
end
