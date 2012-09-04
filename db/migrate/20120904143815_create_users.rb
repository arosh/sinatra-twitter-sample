class CreateUsers < ActiveRecord::Migration
  def up
    create_table :users do |t|
      t.string :twitter_user_id
      t.string :twitter_screen_name
      t.string :twitter_profile_image_url
      t.string :twitter_access_token
      t.string :twitter_access_token_secret
      t.timestamps
    end
  end

  def down
    drop_table :users
  end
end
