class StoriesController < ApplicationController
  def index
    Story.get_top_stories
    all_stories = Story.full_content.order(publish_at: :desc)
    @first_story = all_stories.first
    @story_lists = all_stories.drop(1)
  end
end
