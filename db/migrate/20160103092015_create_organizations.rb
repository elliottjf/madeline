class CreateOrganizations < ActiveRecord::Migration
  def change
    create_table :organizations do |t|
      ## base Contact fields
      t.references :division, index: true
      t.string :display_name
      t.string :legal_name
      t.string :primary_phone
      t.string :secondary_phone
      t.string :fax
      t.string :email
      t.text :street_address  # note, this existing data has some verbose directions stored in this field
      t.string :city
      t.string :neighborhood
      t.string :state
      t.references :country
      t.string :tax_no
      t.string :website
      t.text :notes

      ## distinct Organization fields
      t.string :alias
      t.references :primary_contact  #Person
      t.string :sector
      t.string :industry
      t.string :referral_source
      # t.integer :organization_size
      # t.integer :women_ownership_percent
      # t.integer :poc_ownership_percent
      # t.integer :environmental_impact_score
      t.references :organization_snapshot

      t.timestamps
    end
  end
end
