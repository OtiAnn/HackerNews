class StoriesController < ApplicationController
  def index
    Story.get_top_stories
    all_stories = Story.full_content.order(publish_at: :desc).first(30)
    @first_story = all_stories.first
    @story_lists = all_stories
    @total_pages = Story.full_content.page(1).total_pages
  end

  def get_story_list
    @story_lists = Story.full_content.order(publish_at: :desc).page(params[:page]).per(30)
    render json: @story_lists
  end
end
