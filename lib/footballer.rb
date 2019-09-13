
# require "tty-prompt"
# prompt = TTY::Prompt.new

class Footballer < ActiveRecord::Base

belongs_to :user
belongs_to :match




def self.create_footballers

    Footballer.create(name: "Lionel Messi", value: 10, form: (9..10).to_a.sample, star_rating: 5 , risk_factor: 1 )
    Footballer.create(name: "Christiano Ronaldo", value: 10 , form: (9..10).to_a.sample , star_rating: 5 , risk_factor: 1)
    Footballer.create(name: "Neymar Jr", value: 10 , form: (9..10).to_a.sample , star_rating: 5 , risk_factor: 1)

    Footballer.create(name: "Kylian Mbappe", value: 9 , form: (8..10).to_a.sample , star_rating: 5 , risk_factor: 2 )
    Footballer.create(name: "Eden Hazard" , value: 9, form: (8..10).to_a.sample , star_rating: 5 , risk_factor: 2)
    Footballer.create(name: "Sergio Aguero" , value: 9 , form: (8..10).to_a.sample , star_rating: 5 , risk_factor: 2 )

    Footballer.create(name: "Kevin De Bruyne", value: 8, form: (7..9).to_a.sample, star_rating: 4 , risk_factor: 2 )
    Footballer.create(name: "Raheem Sterling", value: 8, form: (7..9).to_a.sample, star_rating: 4 , risk_factor: 2 )
    Footballer.create(name: "Virgil van Dijk" , value: 8, form: (7..9).to_a.sample , star_rating: 4 , risk_factor: 2 )
    Footballer.create(name: "Luis Suarez", value: 8 , form: (7..9).to_a.sample , star_rating: 4 , risk_factor: 2 )

    Footballer.create(name: "Pierre-Emerick Aubameyang", value: 7 , form: (6..9).to_a.sample, star_rating: 4 , risk_factor:3 )
    Footballer.create(name: "Marc-Andre ter Stegen", value: 7, form: (6..9).to_a.sample, star_rating: 4 , risk_factor: 3 )
    Footballer.create(name: "Marcelo", value: 7, form: (6..9).to_a.sample, star_rating: 4 , risk_factor: 3)
    Footballer.create(name: "Sergio Ramos", value: 7, form: (6..9).to_a.sample, star_rating: 4 , risk_factor: 3)

    Footballer.create(name: "Lucas Torreira", value: 6, form: (5..8).to_a.sample, star_rating: 3 , risk_factor: 3)
    Footballer.create(name: "Cesar Azpilicueta", value: 6, form: (5..8).to_a.sample, star_rating: 3 , risk_factor: 3)
    
    Footballer.create(name: "Declan Rice", value: 5 , form: (5..8).to_a.sample, star_rating: 3 , risk_factor: 3)
    Footballer.create(name: "Wilfried Zaha" , value: 5, form: (4..9).to_a.sample , star_rating: 3 , risk_factor: 5)
    
    Footballer.create(name: "Teemu Pukki", value: 4, form: (3..7).to_a.sample , star_rating: 3 , risk_factor: 4)
    Footballer.create(name: "Ashley Barnes" , value: 4, form: (3..7).to_a.sample , star_rating: 3 , risk_factor: 4)
    

    Footballer.create(name: "Angelo Ogbonna" , value: 3 , form: (2..6).to_a.sample , star_rating: 2 , risk_factor: 4)
    Footballer.create(name: "Ben Cantwell", value: 3, form: (2..6).to_a.sample , star_rating: 2 , risk_factor: 4 )
    Footballer.create(name: "Joe Hart", value: 3, form: (2..6).to_a.sample, star_rating: 2 , risk_factor: 4)
    Footballer.create(name: "Tim Krul", value: 2, form: (1..6).to_a.sample, star_rating: 2 , risk_factor: 5)
    Footballer.create(name: "Tyrone Mings", value: 2, form: (2..6).to_a.sample , star_rating: 2 , risk_factor: 5)
    Footballer.create(name: "Fabien Benko", value: 2, form: (2..6).to_a.sample, star_rating: 2 , risk_factor: 5)

    Footballer.create(name: "Gary from accounting", value: 0 , form: (0..1).to_a.sample , star_rating: 0 , risk_factor: 10)
    Footballer.create(name: "The Wealdstone Raider", value: 0, form: (0..1).to_a.sample, star_rating: 0, risk_factor: 10)
    Footballer.create(name: "Troopz from Arsenal Fan TV", value: 0, form: (0..1).to_a.sample, star_rating: 0, risk_factor: 10)
    
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
    User.all.each{|u| u.bank = 30} 
 end
end


 ####################################################################################################
# def self.title_screen
# font = TTY::Font.new(:doom)

# box = TTY::Box.frame(
#   width: 120,
#   height: 15,
#   align: :center,
#   border: :thick,
#   padding: 3
# ) do
#     font.write("Football    Starz")
    
    
# end
# puts box
# end


# end
