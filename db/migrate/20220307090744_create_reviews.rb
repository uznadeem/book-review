class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.integer :rating, null: false
      t.string :description, limit: 300
      t.belongs_to :reviewable, null: false, polymorphic: true, index: true
      t.belongs_to :user, null: false
      t.timestamps
    end

    add_index :reviews, %i[user_id reviewable_id reviewable_type], unique: true
  end
end
