class CreateTweetlists < ActiveRecord::Migration
  def change
    create_table :tweetlists do |t|
      t.string :content
      t.references :user

      t.timestamps
    end
  end
end
