class CreateOrganizationSnapshots < ActiveRecord::Migration
  def change
    create_table :organization_snapshots do |t|
      t.references :organization, index: true
      t.date :date
      t.integer :organization_size
      t.integer :women_ownership_percent
      t.integer :poc_ownership_percent
      t.integer :environmental_impact_score

      t.timestamps
    end
  end
end
