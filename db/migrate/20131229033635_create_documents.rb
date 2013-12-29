class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
			t.integer :user_id, null: false
			
			t.string :title, null: false
			t.text :content
			t.integer :words, null: false, default: 0
			t.integer :goal, null: false
			
			t.integer :year
			t.integer :month
			t.integer :day
			
      t.timestamps
      
      t.index [:user_id, :year, :month, :day]
    end
  end
end
