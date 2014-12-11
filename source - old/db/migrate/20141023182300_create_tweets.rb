class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string :tweet_content
      t.boolean :sent, default: false

      t.timestamps
    end
  end
end
