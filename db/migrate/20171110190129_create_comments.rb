class CreateComments < ActiveRecord::Migration[5.1]
  def change
  	create_table :users do |t|
      t.string :name
      t.string :email

      t.timestamps
    end
    add_index :users, :email, unique: true
    add_column :users, :password_digest, :string
    add_column :users, :is_admin, :boolean

    create_table :microposts do |t|
      t.string :title
      t.text :content
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :microposts, [:user_id, :created_at]

    create_table :relationships do |t|
      t.integer :follower_id
      t.integer :followed_id

      t.timestamps
    end
    add_index :relationships, :follower_id
    add_index :relationships, :followed_id
    add_index :relationships, [:follower_id, :followed_id], unique: true
    
    create_table :comments do |t|
      t.text :content
      t.references :user, foreign_key: true
      t.references :micropost, foreign_key: true

      t.timestamps
    end
    add_index :comments, [:micropost_id, :created_at]
  end
end
