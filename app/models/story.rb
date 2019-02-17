require 'nokogiri'
require 'open-uri'

class Story < ApplicationRecord
  scope :full_content, -> { where.not(url: nil, image_url: nil, description: nil) }

  def self.get_top_stories
    array = JSON.load(open("https://hacker-news.firebaseio.com/v0/topstories.json"))
    new_stories = array.first(150) - Story.pluck(:story_uid)
    new_stories.map do |story_id|
      get_story_info(story_id)
    end
  end

  private
  
  def self.get_story_info story_id
    story_info = JSON.load(open("https://hacker-news.firebaseio.com/v0/item/#{story_id}.json"))
    story_uid = story_info["id"]
    story_title = story_info["title"]
    story_url = story_info["url"]
    story_time = Time.at(story_info["time"])
    story_meta_tag = get_image_and_desc(story_url)
    story_image_url = story_meta_tag[:image_url]
    story_desc = story_meta_tag[:desc]
    Story.create!(title: story_title, url: story_url, publish_at: story_time,
      image_url: story_image_url, description: story_desc,
      story_uid: story_uid)
  end

  def self.get_image_and_desc url
    return {} if url.nil?
    begin
      doc = Nokogiri::HTML(open(url))
      story_meta_tag = {}
      if doc.search("meta[property='og:image']").present?
        story_meta_tag[:image_url] = doc.search("meta[property='og:image']").first['content']
      end
      if doc.search("meta[name='description']").present?
        story_meta_tag[:desc] = doc.search("meta[name='description']").first['content']
      end
      return story_meta_tag
    rescue => e
      puts ">>>>>>>>>>> Failure: #{e}"
      return {}
    end
  end
end
