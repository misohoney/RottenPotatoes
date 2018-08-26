class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.integer :movie_id
      t.string :user_name
      t.string :user_email
      t.integer :rating
      t.text :comment

      t.timestamps
    end
  end
end