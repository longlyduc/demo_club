class Activity < ApplicationRecord
  belongs_to :target, polymorphic: true
  belongs_to :person_target, polymorphic: true
end
