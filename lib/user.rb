class User < ActiveRecord::Base

has_many :footballers

def self.create_user(name)
    new_user = User.create
    new_user.name = name
    new_user.save
    new_user
end

def self.show_footballers(user_name)
    new_user = User.find_by(name: user_name)
    new_user.footballers.select(:name, :value, :star_rating, :risk_factor, :id)
end

def self.create_user(name)
    #this method creates a new user
    User.create(name)
end


def self.clear_users #this would delete all users and reset all player data
    self.destroy_all
    Match.destroy_all
    Footballer.destroy_all
    Footballer.create_footballers
    Match.create(name: "The Big Game!")
end

    


end