class Activity < ApplicationRecord
  belongs_to :target, polymorphic: true
  belongs_to :person_target, polymorphic: true

  has_many :comments, as: :target, dependent: :destroy
end
