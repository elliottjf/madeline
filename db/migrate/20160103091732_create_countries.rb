class CreateCountries < ActiveRecord::Migration
  def change
    create_table :countries do |t|
      t.string :name
      t.string :code
      #todo: consider dropping these
      t.references :default_language
      t.references :default_currency

      t.timestamps
    end
  end
end
