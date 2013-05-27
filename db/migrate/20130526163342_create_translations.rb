class CreateTranslations < ActiveRecord::Migration
  def change
    create_table :translations do |t|
      t.integer :lang_id
      t.integer :word_id
      t.string :text
      t.text :desc

      t.timestamps
    end
  end
end
