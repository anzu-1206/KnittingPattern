class Bookmark < ApplicationRecord
  belongs_to :user
  belongs_to :pattern

  validates :user_id, uniqueness: { scope: :pattern_id }
end
