class CreateFootballer < ActiveRecord::Migration[5.0]
  
  def change
    create_table :footballers do |t|
      t.string :name
      t.float :value
      t.float :form
      t.integer :star_rating
      t.integer :risk_factor
      t.integer :user_id
      t.integer :match_id
    end
  end


  
end
