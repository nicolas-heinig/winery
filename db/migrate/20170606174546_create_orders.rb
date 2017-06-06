class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.belongs_to :customer, foreign_key: true
      t.belongs_to :wine, foreign_key: true
      t.integer :boxes
      t.integer :bottles
      t.boolean :shipped

      t.timestamps
    end
  end
end
