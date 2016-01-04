class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      ## base Contact fields
      t.references :division, index: true
      t.string :display_name
      t.string :legal_name
      t.string :primary_phone
      t.string :secondary_phone
      t.string :fax
      t.string :email
      t.string :street_address
      t.string :city
      t.string :neighborhood
      t.string :state
      t.references :country
      t.string :tax_no
      t.string :website
      t.text :notes
      t.timestamps
      ## distinct Person fields
      t.string :first_name
      t.string :last_name
      t.references :primary_organization, index: true

    end
  end
end
