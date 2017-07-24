class Fg < ActiveRecord::Migration[5.1]
  def change
  	drop_table :conversations
  end
end
