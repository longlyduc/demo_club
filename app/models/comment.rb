class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :target, polymorphic: true

  scope :sort_comment, -> {order created_at: :desc}
end
