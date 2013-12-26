class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
			t.string :username, null: false, limit: 24
    	t.string :password_digest, null: false
    	t.string :email, null: false, limit: 128
    	t.integer :ip, limit: 8
      t.timestamps
      
      t.index :username
    end
  end
end
