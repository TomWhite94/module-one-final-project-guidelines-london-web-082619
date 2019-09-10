class CreateMatch < ActiveRecord::Migration[5.0]
  
  def change
    create_table :matches do |t|
      t.string :name
    end
  end
end
