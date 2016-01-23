class Post < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :media, unless: :content?
  validates_presence_of :content, unless: :media?
end
