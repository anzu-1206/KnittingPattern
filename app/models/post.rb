class Post < ApplicationRecord
    belongs_to :user, dependent: :destroy
    belongs_to :pattern, dependent: :destroy
    has_many :bookmarks, dependent: :destroy
end
