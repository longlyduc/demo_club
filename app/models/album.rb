class Album < ApplicationRecord
  has_many :images, dependent: :destroy

  belongs_to :club

  validates :name, presence: true, length: {minimum: Settings.min_name}

  scope :newest, -> {order created_at: :desc}
end
