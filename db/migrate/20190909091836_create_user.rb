class CreateUser < ActiveRecord::Migration[5.0]
  
  def change
    create_table :users do |t|
      t.string :name
      t.float :bank, :default => 30
    end
  end
end
