class Item < ActiveRecord::Base
    belongs_to :user

    # does not let user create a blank item or leave any fields blank
    validates :title, presence: true
    validates :description, presence: true
    validates :price, presence: true, format: { with: /\d{1,3}(?:[.,]\d{3})*(?:[.,]\d{2})/, message: "must be in x.xx format" }
    validates :image, presence: true
    
end