class Post < ActiveRecord::Base
  mount_uploader :picture, PictureUploader
  belongs_to :user

  validates_presence_of :name, :content, :user_id, :picture

  before_destroy :delete_image_from_cloud

  private

  def delete_image_from_cloud
    Thread.new { a.remove_picture! }   
  end

end
