class Image < ApplicationRecord
  belongs_to :album
  belongs_to :user

  mount_uploader :url, ImageUploader

  validates :name, presence: true, length: {minimum: Settings.min_name}
  validates :url, presence: true
end
