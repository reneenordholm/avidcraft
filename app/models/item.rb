class Item < ActiveRecord::Base
    belongs_to :user

    validates :title, presence: true
    validates :description, presence: true
    validates :price, presence: true, format: { with: /(^[+-]?[0-9]{1,3}(?:,?[0-9]{3})*\.[0-9]{2}$)/, message: "must be in x.xx format" }
    validates :image, presence: true, format: { with: /(https?:\/\/.*\.(?:gif|png|jpg|jpeg))/i , message: "URL must begin with http or https and end with .gif, .jpg, .jpeg, or .png" }
end