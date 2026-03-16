class Bookmark < ApplicationRecord
  belongs_to :user, dependent: :destroy
  belongs_to :pattern, dependent: :destroy

  validates :user_id, uniqueness: { scope: :pattern_id }
end
