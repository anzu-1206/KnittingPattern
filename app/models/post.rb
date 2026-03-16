class Post < ApplicationRecord
    belongs_to :user
    belongs_to :pattern
    has_many :bookmarks, dependent: :destroy
end
