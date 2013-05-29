class CreateDictionaries < ActiveRecord::Migration
  def change
    create_table :dictionaries do |t|
      t.string :from
      t.string :to
      t.integer :position

      t.timestamps
    end
  end
end
