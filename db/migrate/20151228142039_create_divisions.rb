class CreateDivisions < ActiveRecord::Migration
  def change
    create_table :divisions do |t|
      t.string :name
      t.text :description
      t.references :parent #Division
      t.references :default_currency
      # t.array :priority_language_ids  #todo once dependent functionality flushed out

      t.timestamps
    end
  end
end
