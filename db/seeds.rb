User.create(name: "Zero Farkhe 30")
User.create(name: "Willian Dollar Baby")
User.create(name: "Too Many Brooks")
User.create(name: "My Little Bony")
User.create(name: "Haller Back Girl")

Match.create(name: "The Big Game!!!")

def rand_num_value
    (1..10).to_a.sample
end

def rand_num_star
    (1..5).to_a.sample
end


Footballer.create(name: "Lionel Messi", value: rand_num_value ,form: rand_num_value ,star_rating: rand_num_star ,risk_factor: rand_num_star)
Footballer.create(name: "Christiano Ronaldo", value: rand_num_value ,form: rand_num_value ,star_rating: rand_num_star ,risk_factor: rand_num_star)
Footballer.create(name: "Eden Hazard", value: rand_num_value ,form: rand_num_value ,star_rating: rand_num_star ,risk_factor: rand_num_star)
Footballer.create(name: "Kevin De Bruyne", value: rand_num_value ,form: rand_num_value ,star_rating: rand_num_star ,risk_factor: rand_num_star)
Footballer.create(name: "Neymar Jr", value: rand_num_value ,form: rand_num_value ,star_rating: rand_num_star ,risk_factor: rand_num_star)
Footballer.create(name: "Kylian Mbappe", value: rand_num_value ,form: rand_num_value ,star_rating: rand_num_star ,risk_factor: rand_num_star)
Footballer.create(name: "Joao Felix", value: rand_num_value ,form: rand_num_value ,star_rating: rand_num_star ,risk_factor: rand_num_star)
Footballer.create(name: "Paul Pogba", value: rand_num_value ,form: rand_num_value ,star_rating: rand_num_star ,risk_factor: rand_num_star)
Footballer.create(name: "Antoine Griezmann", value: rand_num_value ,form: rand_num_value ,star_rating: rand_num_star ,risk_factor: rand_num_star)
Footballer.create(name: "Marcus Rashford", value: rand_num_value ,form: rand_num_value ,star_rating: rand_num_star ,risk_factor: rand_num_star)





