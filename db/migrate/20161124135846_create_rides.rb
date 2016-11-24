class CreateRides < ActiveRecord::Migration
  def change
    create_table :rides do |t|
      t.belongs_to :user, index: true
      t.belongs_to :attraction, index: true

      t.timestamps null: false
    end
    add_foreign_key :rides, :users
    add_foreign_key :rides, :attractions
  end
end
