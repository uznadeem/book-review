class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.date :publish_date
      t.decimal :rating
      t.references :author, foreign_key: true
      t.timestamps
    end
  end
end
