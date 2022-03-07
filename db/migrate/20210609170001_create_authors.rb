class CreateAuthors < ActiveRecord::Migration[6.1]
  def change
    create_table :authors do |t|
      t.string(:first_name)
      t.string(:last_name)
      t.string(:website)
      t.string(:genres, array: true, default: [])
      t.text(:description)
      t.timestamps
    end
  end
end
