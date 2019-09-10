class Match < ActiveRecord::Base

    has_many :footballers

    
    def self.total_score(user_name)

        new_user = User.find_by(name: user_name)
        new_user.footballers.sum{|f| f.form}
    
    end

    def self.winner(user_name1, user_name2)

        if total_score(user_name1) > total_score(user_name2)
            "#{user_name1} is the winner with a score of #{total_score(user_name1)}! Bad luck to #{user_name2}, who only scored #{total_score(user_name2)}"
        elsif total_score(user_name1) < total_score(user_name2)
            "#{user_name2} is the winner with a score of #{total_score(user_name2)}! Bad luck to #{user_name1}, who only scored #{total_score(user_name1)}"
        else
            "It's a draw! Both teams scored #{total_score(user_name1)}"
        end

    end



    





    
end
