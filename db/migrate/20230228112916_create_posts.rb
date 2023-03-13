class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.text :url
      t.string :name
      t.string :kikan
      t.date :kigen
      t.date :syuryo
      t.string :mail
      t.text :about

      t.timestamps
    end
  end
end
