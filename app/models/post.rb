class Post < ApplicationRecord
    belongs_to :user

    has_many :likes, dependent: :destroy
    has_many :liked_users, through: :likes, source: :user

    has_many :tag_maps, dependent: :destroy
    has_many :tags, through: :tag_maps

    def save_tag(sent_tags)
        current_tags = self.tags.pluck(:tag_name) unless self.tags.nil?
        old_tags = current_tags - sent_tags
        new_tags = sent_tags - current_tags
   
        old_tags.each do |old|
          self.tags.delete Tag.find_by(tag_name: old)
        end
   
        new_tags.each do |new|
          new_post_tag = Tag.find_or_create_by(tag_name: new)
          self.tags << new_post_tag
        end
      end
end
