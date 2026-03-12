class Pattern < ApplicationRecord
    belongs_to :user

    def self.ransackable_attributes(auth_object = nil)
        ["title"]
    end

    def self.ransackable_associations(auth_object = nil)
        ["image_attachment", "image_blob"]
    end

    has_one_attached :image
end
