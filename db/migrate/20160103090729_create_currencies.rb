class CreateCurrencies < ActiveRecord::Migration
  def change
    create_table :currencies do |t|
      t.string :name
      t.string :symbol
      t.string :code
#      t.decimal :current_exchange_rate, precision: 12, scale: 4  #todo once dependent functionality flushed out

      t.timestamps
    end
  end
end
