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

    def rules
        puts "Game Rules:".colorize(:blue)
        puts "1. Each player has £30 to spend on a five-a-side team".colorize(:blue)
        puts "2. You cannot choose a player that has already been picked".colorize(:blue)
        puts "3. Spend all your money before you have a full team and you risk having Gary from accounting filling in...".colorize(:blue)

    end

    def start 
        choice = @prompt.select("Choose an option", ["Create your team", "Exit game"])
        if choice == "Exit game"
            exit
        else
        name = @prompt.ask("Choose your team name")
        User.create(name: name)
        puts "Your team has been created! Your team is called #{name} and you have £30 to spend".colorize(:blue)
        end
    end

    def start2
        choice = @prompt.select("Choose an option", ["Create your opponent's team", "Exit game"])
        if choice == "Exit game"
            exit
        else
        name = @prompt.ask("Choose your team name")
        User.create(name: name)
        puts "Your team has been created! Your team is called #{name} and you have £30 to spend".colorize(:blue)
        end
    end
        

    def choose_team_user1
        

        players = Footballer.all.map{|m| "#{m.name}, Value: #{m.value}, Rating: #{m.star_rating}, Risk: #{m.risk_factor}"}
        
        choose = @prompt.select("Choose your players!", [players]).split(/,/)

        index = players.find_index {|player| player == choose.join(",")}
        players[index].colorize(:blue)
        players
        
        
            choice = Footballer.find_by(name: choose[0])
            @first_user = User.all.first

            if choice.user != nil #ensuring the user isn't signing someone who has already been signed
                puts "This player has already been picked, choose someone else!".colorize(:red)
                choose_team_user1
            elsif @first_user.bank < choice.value #ensuring the user isn't signing someone they can't afford
                puts "You can't afford this player, choose someone else".colorize(:red)   
                choose_team_user1
                
            
            else 
                choice.user = @first_user #set the user_id of the footballer to match the user
                @first_user.bank -= choice.value
                puts "You have added #{choice.name} to your team!".colorize(:green)
                
            end

            choice.save
            @first_user.save
        
            puts "You have £#{@first_user.bank} remaining!".colorize(:blue)
           
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
                puts "This player has already been picked, choose someone else!".colorize(:red)
                choose_team_user2
            elsif @last_user.bank < choice.value #ensuring the user isn't signing someone they can't afford
                puts "You can't afford this player, choose someone else".colorize(:red)
                choose_team_user2
                
            
            else 
                choice.user = @last_user #set the user_id of the footballer to match the user
                @last_user.bank -= choice.value
                puts "You have added #{choice.name} to your team!".colorize(:green)
                
            end

            choice.save
            @last_user.save
        
            puts "You have £#{@last_user.bank} remaining!".colorize(:blue)
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
                puts "You have £#{users.bank} left!".colorize(:blue)
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
            puts "You have £#{users.bank} left!".colorize(:blue)
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
            full_team_last = User.all.last.footballers.map{|m| m.name}
            x = 0
            while full_team_last.length > x do
                puts "#{x + 1}. #{full_team_last[x]}"
                x += 1
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

    def team_1
        User.all.first.name
        
    end

    def team_2 
        User.all.last.name
    end

    def play_game
        
        options = @prompt.select("Choose an option", ["Play the match", "View teams"])
        if options == "View teams"
            view_teams
        end

        if options == "Play the match"

            quotes_array = ["The ball has been kicked outside the stadium... there has been a pause in the game".colorize(:red), "There is half naked chap on the field, the game has been delayed".colorize(:red), "Looks like one of the players has been injured! Oh, he just got a yellow card for diving! The play resumes".colorize(:red), "The ball has been punctured... The ref is trying to find a new one".colorize(:red), "The ref has briefly misplaced his whistle, play will resume once it is located".colorize(:red), "Mark Lawrenson is commencing his obligatory VAR-related moan".colorize(:red), "GOAL!! Oh no it's been disallowed".colorize(:red), "This game could go either way, nothing separating these two teams".colorize(:red), "Both managers are tearing their hair out on the sidelines! Very poor football".colorize(:red), "Oh dear! You really should not be missing open goals at this level of the game".colorize(:red)]
            sleep(1)
            puts "There's a huge roar from the crowd as the match gets underway".colorize(:green)
            sleep(2)
            puts quotes_array.sample
            sleep(3)
            puts quotes_array.sample
            sleep(3)
            puts "Half time".colorize(:green)
            sleep(3)
            puts quotes_array.sample
            sleep(3)
            puts quotes_array.sample
            sleep(2)
            puts "And there is the full time whistle!".colorize(:green)
            sleep(2)
            if total_score_user1 > total_score_user2
            
    
            box = TTY::Box.frame(
                        width: 50,
                        height: 10,
                        align: :center,
                        border: :thick,
                        padding: 1
                        ) do
                            
                            "The final score is: #{team_1} #{total_score_user1} - #{total_score_user2} #{team_2} Congratulations #{team_1} you have won!!!"
                        end

                        puts box

    
                # puts "The final score is: #{@first_team} #{total_score_user1} - #{total_score_user2} #{@last_team}"
                # puts "Congratulations #{@first_team} you have won!!!"
            elsif total_score_user1 < total_score_user2
                box = TTY::Box.frame(
                        width: 50,
                        height: 10,
                        align: :center,
                        border: :thick,
                        padding: 1
                        ) do
                            
                            "The final score is: #{team_1} #{total_score_user1} - #{total_score_user2} #{team_2} Congratulations #{team_2} you have won!!!"
                        
                        end

                        puts box
                # puts "The final score is: #{@first_team} #{total_score_user1} - #{total_score_user2} #{@last_team}"
                # puts "Congratulations #{@last_team} you have won!!!"
            else
                box = TTY::Box.frame(
                        width: 50,
                        height: 10,
                        align: :center,
                        border: :thick,
                        padding: 1
                        ) do
                            
                            "The final score is: #{team_1} #{total_score_user1} - #{total_score_user2} #{team_2} It's a draw!"
                        
                        end
                # puts "The final score is: #{@first_team} #{total_score_user1} - #{total_score_user2} #{@last_team}"
                # puts "It's a draw!"
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
        rules
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






