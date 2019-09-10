require "tty-prompt"
prompt = TTY::Prompt.new

def run_program
    main_menu
end

###########################################
###########################################
###########################################



$user_input = prompt.select("Select", %w(users footballers))



def main_menu
    if $user_input == "users"
        puts "These are the users"

    elsif $user_input == "footballers"
        puts "These are the footballers"
    else
        "choose an option"
    end


    
    
end




