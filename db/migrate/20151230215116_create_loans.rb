class CreateLoans < ActiveRecord::Migration
  def change
    create_table :loans do |t|
      ## base Project fields
      t.references :division, index: true
      t.references :organization, index: true
      t.string :name
      # translatable: summary
      # translatable: details
      t.references :primary_agent #Person
      t.references :secondary_agent #Person
      t.integer :status_option_id, index: true
      t.integer :project_type_option_id
      ## distinct Loan fields
      t.integer :loan_type_option_id, index: true
      t.integer :public_level_option_id, index: true
      t.decimal :amount, precision: 12, scale: 2
      t.references :currency
      t.decimal :rate, precision: 8, scale: 4
      t.integer :length_months
      t.references :representative  #Person
      t.date :signing_date
      t.date :first_payment_date
      t.date :first_interest_payment_date
      t.date :target_end_date
      t.decimal :projected_return, precision: 12, scale:2
      ## historical values captured from organization when loan created
      # t.integer :organization_size
      # t.integer :women_ownership_percent
      # t.integer :poc_ownership_percent
      # t.integer :environmental_impact_score
      t.references :organization_snapshot

      t.timestamps
    end
  end
end
