Rails.application.routes.draw do
  root 'stories#index'
  get 'stories/get_story_list'
end
