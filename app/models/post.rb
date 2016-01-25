class Post < ActiveRecord::Base
  belongs_to :user, -> { select('id, name, latitude, longitude, picture_url') }
  validates_presence_of :media, unless: :content?
  validates_presence_of :content, unless: :media?

  def as_json(options = nil)
    super({ include: :user }.merge(options || {}))
  end
end
