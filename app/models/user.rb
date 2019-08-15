class User < ActiveRecord::Base
    has_secure_password
    has_many :items

    # Password can't be blank
    # Password must be between 6-20 characters
    # Username can't be blank
    # Username must be unique
    # Username minimum length is 4 characters.
    # Username cannot contain blank space numbers, special characters
    # Email can't be blank
    # Email must be in format xxxx@xxxx.xxx
    validates :username, presence: true, uniqueness: true, length: { minimum: 4 }, format: { with: /\A[a-zA-Z]+\z/, message: "cannot contain blank space, numbers, or special characters" }
    validates :email, presence: true, format: { with: /[^@]+@[^\.]+\..+/, message: "must be in format xxxx@xxxx.xxx"}
    validates :password, presence: true, length: { in: 6..20 }

    # slugs the username
    def slug
        self.username.gsub(" ", "-").downcase
    end

    # finds user based on slug
    def self.find_by_slug(slug)
        self.all.find{ |user| user.slug == slug }
    end

end