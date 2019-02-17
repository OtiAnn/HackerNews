class StoriesController < ApplicationController
  def index
    Story.get_top_stories
    all_stories = Story.full_content.order(publish_at: :desc).first(30)
    @first_story = all_stories.first
    @story_lists = all_stories
    @total_pages = Story.full_content.page(1).total_pages
  end

  def get_story_list
    full_content = Story.full_content.order(publish_at: :desc)
    case params[:filter]
    when "odd"
      odd_stories = full_content.each_with_index.select { |story, i| i % 2 == 0 }
      @story_lists = Kaminari.paginate_array(odd_stories).page(params[:page]).per(30)
    when "even"
      even_stories = full_content.each_with_index.select { |story, i| i % 2 == 1 }
      @story_lists = Kaminari.paginate_array(even_stories).page(params[:page]).per(30)
    else
      all_stories = full_content.each_with_index.select { |story, i| i % 1 ==  0 }
      @story_lists = Kaminari.paginate_array(all_stories).page(params[:page]).per(30)
    end
    render json: @story_lists
  end
end
