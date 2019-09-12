require_relative '../config/environment.rb'
require "tty-prompt"
require "pry"
require "colorize"
require "colorized_string"

class Cli

def initialize
    @prompt = TTY::Prompt.new
    @user = nil
end




###########################################
###########################################
###########################################

def title_screen
    font = TTY::Font.new(:doom)
    
    box = TTY::Box.frame(
    width: 90,
    height: 10,
    align: :center,
    border: :thick,
    padding: 1
    ) do
        font.write("Football    Starz")
        # "Football Starz"
    end

    puts box

    end

    def start 
        choice = @prompt.select("Choose an option", ["Create your team", "Exit game"])
        if choice == "Exit game"
            exit
        else
        name = @prompt.ask("Choose your team name")
        User.create(name: name)
        puts "Your team has been created! Your team is called #{name} and you have £30 to spend"
        end
    end

    def start2
        choice = @prompt.select("Choose an option", ["Create your opponent's team", "Exit game"])
        if choice == "Exit game"
            exit
        else
        name = @prompt.ask("Choose your team name")
        User.create(name: name)
        puts "Your team has been created! Your team is called #{name} and you have £30 to spend"
        end
    end

    # def remove_player_user1
    #     first_user = User.all.first
    #     player = first_user.footballers.last
    #     player.user = nil
    #     first_user.bank += player.value
    #     puts "#{player.name} has been removed from your team. Your current bank is #{first_user.bank}"
    #     first_user.save
    #     player.save
    # end
        

    def choose_team_user1
        

        players = Footballer.all.map{|m| "#{m.name}, Value: #{m.value}, Rating: #{m.star_rating}, Risk: #{m.risk_factor}".colorize(:blue)}
        
        choose = @prompt.select("Choose your players!", [players]).split(/,/)

        # if @choose == "Remove previous player"
        #     remove_player_user1
        
        # else @choose == "Exit game"
        #     exit
        # end
            
        

    
            choice = Footballer.find_by(name: choose[0])
            @first_user = User.all.first

            if choice.user != nil #ensuring the user isn't signing someone who has already been signed
                puts "This player has already been picked, choose someone else!"
                choose_team_user1
            elsif @first_user.bank < choice.value #ensuring the user isn't signing someone they can't afford
                puts "You can't afford this player, choose someone else"    
                choose_team_user1
                
            
            else 
                choice.user = @first_user #set the user_id of the footballer to match the user
                @first_user.bank -= choice.value
                puts "You have chosen #{choice.name} to your team!"
                
            end

            choice.save
            @first_user.save
        
            puts "You have £#{@first_user.bank} remaining!"
           
    end

    def choose_team_user2
        players = Footballer.all.map{|m| "#{m.name}, Value: #{m.value}, Rating: #{m.star_rating}, Risk: #{m.risk_factor}"}
        choose = @prompt.select("Choose your players!", [players]).split(/,/)

        # if @choose == "Remove previous player"
        #     remove_player_user1
        
        # else @choose == "Exit game"
        #     exit
        # end
            
        

    
            choice = Footballer.find_by(name: choose[0])
            @last_user = User.all.last
            if choice.user != nil #ensuring the user isn't signing someone who has already been signed
                puts "This player has already been picked, choose someone else!"
                choose_team_user2
            elsif @last_user.bank < choice.value #ensuring the user isn't signing someone they can't afford
                puts "You can't afford this player, choose someone else"    
                choose_team_user2
                
            
            else 
                choice.user = @last_user #set the user_id of the footballer to match the user
                @last_user.bank -= choice.value
                puts "You have chosen #{choice.name} to your team!"
                
            end

            choice.save
            @last_user.save
        
            puts "You have £#{@last_user.bank} remaining!"
        end

        def team_edits1
            users = User.all.first
            edits = @prompt.select("Are you happy with your team?", ["Yes", "No"])
            if edits == "No"
                replace = @prompt.select("Who do you want to replace?", [User.all.first.footballers.map{|m| "#{m.name}, Value: #{m.value}, Rating: #{m.star_rating}, Risk: #{m.risk_factor}"}]).split(/,/)
                player = Footballer.find_by(name: replace[0])
                users.bank += player.value
                player.user = nil
                player.save
                users.save
                puts "You have £#{users.bank} left!"
                choose_team_user1
                team_edits1
                
        
        else
           
            
        end
    end
    def team_edits2
        users = User.all.last
        edits = @prompt.select("Are you happy with your team?", ["Yes", "No"])
        if edits == "No"
            replace = @prompt.select("Who do you want to replace?", [User.all.last.footballers.map{|m| "#{m.name}, Value: #{m.value}, Rating: #{m.star_rating}, Risk: #{m.risk_factor}"}]).split(/,/)
            player = Footballer.find_by(name: replace[0])
            users.bank += player.value
            player.user = nil
            player.save
            users.save
            puts "You have £#{users.bank} left!"
            choose_team_user2
            team_edits2
            
    
    else
       
        
    end
end

   
        def back
         back = @prompt.select("Go back?", ["OK"])
        if back == "OK"
            view_teams
        end
    end

   
   def view_teams
        @first_team = User.all.first.name
        @last_team = User.all.last.name
        user = @prompt.select("Which team would you like to view?", [@first_team, @last_team, "Back"])
        if user == @first_team
            full_team = User.all.first.footballers.map{|m| m.name}
            i = 0
            while full_team.length > i do
                puts "#{i + 1}. #{full_team[i]}"
                i += 1
            end
            back
                
        end
        if user == @last_team
            full_team2 = User.all.last.footballers.map{|m| m.name}
            x = 0
            while full_team2.length > x do
                puts "#{x + 1}. #{full_team2}"
                i += 1
            end
            back
        end

        if user == "Back"
            play_game
        end
    end

    def total_score_user1
        User.all.first.footballers.sum{|m| m.form}
    end


    def total_score_user2
        User.all.last.footballers.sum{|m| m.form}
    end
   

    def play_game
        
        options = @prompt.select("Choose an option", ["Play the match", "View teams"])
        if options == "View teams"
            view_teams
        end

        if options == "Play the match"
            if total_score_user1 > total_score_user2
                puts "The final score is: #{@first_team} #{total_score_user1} - #{total_score_user2} #{@last_team}"
                puts "Congratulations #{@first_team} you have won!!!"
            elsif total_score_user1 < total_score_user2
                puts "The final score is: #{@first_team} #{total_score_user1} - #{total_score_user2} #{@last_team}"
                puts "Congratulations #{@last_team} you have won!!!"
            else
                puts "The final score is: #{@first_team} #{total_score_user1} - #{total_score_user2} #{@last_team}"
                puts "It's a draw!"
            end
            

            

                

        end

    
    end

    def play_again?
            again = @prompt.select("Would you like to play again?", ["Play again", "Exit"])
                if again == "Play again"
                    User.clear_users
                    Footballer.reset_game
                    run_program
                end
                if again == "Exit"
                    User.clear_users
                    Footballer.reset_game
                    puts "Play again soon!"
                    exit
                    
                end
            end


            
        def run_program
            User.clear_users
            Footballer.reset_game 
        title_screen
        start
        while User.all.first.footballers.length < 5 do
        choose_team_user1
        end
        team_edits1
        puts "The team #{User.all.first.name} has been created! Your players are: #{User.all.first.footballers.map{|m| m.name}}"
        title_screen
        start2
        while User.all.last.footballers.length < 5 do
            choose_team_user2
        end
        puts "The team #{User.all.last.name} has been created! Your players are: #{User.all.last.footballers.map{|m| m.name}}"
        team_edits2
        title_screen
        play_game
        play_again?
    end





end






