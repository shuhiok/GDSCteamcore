class CreateEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :events do |t|
      t.string :name
      t.string :community
      t.date :day
      t.text :about
      t.text :url

      t.timestamps
    end
  end
end
