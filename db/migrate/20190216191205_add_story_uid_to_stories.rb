class AddStoryUidToStories < ActiveRecord::Migration[5.2]
  def change
    add_column :stories, :story_uid, :integer
  end
end
