class Footballer < ActiveRecord::Base

belongs_to :user
belongs_to :match




def self.create_footballers

    Footballer.create(name: "Lionel Messi", value: (1..2).to_a.sample ,form: (1..10).to_a.sample ,star_rating: (1..5).to_a.sample ,risk_factor: (1..5).to_a.sample)
    Footballer.create(name: "Christiano Ronaldo", value: (1..2).to_a.sample ,form: (1..10).to_a.sample ,star_rating: (1..5).to_a.sample ,risk_factor: (1..5).to_a.sample)
    Footballer.create(name: "Eden Hazard", value: (1..2).to_a.sample ,form: (1..10).to_a.sample ,star_rating: (1..5).to_a.sample ,risk_factor: (1..5).to_a.sample)
    Footballer.create(name: "Kevin De Bruyne", value: (1..2).to_a.sample ,form: (1..10).to_a.sample ,star_rating: (1..5).to_a.sample ,risk_factor: (1..5).to_a.sample)
    Footballer.create(name: "Neymar Jr", value: (1..2).to_a.sample ,form: (1..10).to_a.sample ,star_rating: (1..5).to_a.sample ,risk_factor: (1..5).to_a.sample)
    Footballer.create(name: "Kylian Mbappe", value: (1..2).to_a.sample ,form: (1..10).to_a.sample ,star_rating: (1..5).to_a.sample ,risk_factor: (1..5).to_a.sample)
    Footballer.create(name: "Joao Felix", value: (1..10).to_a.sample ,form: (1..10).to_a.sample ,star_rating: (1..5).to_a.sample ,risk_factor: (1..5).to_a.sample)
    Footballer.create(name: "Paul Pogba", value: (1..10).to_a.sample ,form: (1..10).to_a.sample ,star_rating: (1..5).to_a.sample ,risk_factor: (1..5).to_a.sample)
    Footballer.create(name: "Antoine Griezmann", value: (1..10).to_a.sample ,form: (1..10).to_a.sample ,star_rating: (1..5).to_a.sample ,risk_factor: (1..5).to_a.sample)
    Footballer.create(name: "Marcus Rashford", value: (1..10).to_a.sample ,form: (1..10).to_a.sample ,star_rating: (1..5).to_a.sample ,risk_factor: (1..5).to_a.sample)

end

def self.add_to_user(footballer_name, user_name)
    
    new_footballer = self.find_by(name: footballer_name)
    new_user = User.find_by(name: user_name)
#Finds the user and a footballer as defined by the method arguments
    if new_footballer.user_id != nil
        "This player has already been picked!" 
    
    elsif new_user.bank < 0
        "You can't afford that!"
    
 #Tests to ensure that the player hasn't spent more than they can afford, the player hasn't already been picked, or the user hasn't already selected 5 players          

    elsif new_user.footballers.length > 4
        "You can't have more than 5 players!"
    
    else
    new_footballer.user = new_user
    new_footballer.match = Match.first
#Assigns the user's ID to a footballer and assigns the match ID to the footballer
    new_user.bank -= new_footballer.value
#Removes the footballer's value from the user's bank balance
    new_user.save
    new_footballer.save
    new_footballer
#Saves to the database
    end
 end

 
 
 def self.remove_player(footballer_name, user_name)
    remove_footballer = self.find_by(name: footballer_name)
    remove_user = User.find_by(name: user_name)
    remove_user.bank += remove_footballer.value
    remove_footballer.user = nil
    remove_footballer.save
    remove_user.save
 end



 def self.reset_game #this will reset the game, but keep current users
    Match.destroy_all
    self.destroy_all
    self.create_footballers
    Match.create(name: "The Big Game!")
    User.all.each{|u| u.bank = 35} 
 end



end
