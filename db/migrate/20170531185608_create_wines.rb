class CreateWines < ActiveRecord::Migration[5.0]
  def change
    create_table :wines do |t|
      t.string :name
      t.float :volume
      t.decimal :bottle_price, :precision => 8, :scale => 2
      t.decimal :box_price, :precision => 8, :scale => 2
      t.integer :year
      t.string :from
      t.string :wine_type

      t.timestamps
    end
  end
end
