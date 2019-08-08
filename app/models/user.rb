class User < ActiveRecord::Base
    has_secure_password
    has_many :items

    # slugs the username
    def slug
        self.username.gsub(" ", "-").downcase
    end

    # finds user based on slug
    def self.find_by_slug(slug)
        self.all.find{ |user| user.slug == slug }
    end

end