class Pattern < ApplicationRecord
    belongs_to :user
    has_many :post

    def self.ransackable_attributes(auth_object = nil)
        ["title"]
    end

    def self.ransackable_associations(auth_object = nil)
        ["image_attachment", "image_blob"]
    end

    scope :published, -> {where(is_public: true)}
    scope :unpublished, -> {where(is_public: false)}

    has_one_attached :image
end
