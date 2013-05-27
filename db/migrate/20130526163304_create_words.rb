class CreateWords < ActiveRecord::Migration
  def change
    create_table :words do |t|
      t.integer :lang_id
      t.string :text

      t.timestamps
    end
  end
end
