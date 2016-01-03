class CreateLoans < ActiveRecord::Migration
  def change
    create_table :loans do |t|
      t.string :name
      t.decimal :amount, precision: 12, scale: 2
      t.decimal :rate, precision: 8, scale: 4
      t.integer :length_months
      t.references :division, index: true

      t.timestamps
    end
  end
end
