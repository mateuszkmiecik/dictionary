class CreateLanguages < ActiveRecord::Migration
  def change
    create_table :languages do |t|
      t.string :short
      t.string :name

      t.timestamps
    end
  end
end
