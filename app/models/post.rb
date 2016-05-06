class Post < ActiveRecord::Base
  mount_uploader :picture, PictureUploader
  
  belongs_to :user
  
  validates_presence_of :name, :content, :user_id, :picture
  
end
