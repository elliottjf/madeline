class Organization < ActiveRecord::Base
  #todo: factor out base Contact class

  # create_table :organizations do |t|
  ## base Contact fields
  #   t.references :division, index: true
  #   t.string :display_name
  #   t.string :legal_name
  #   t.string :primary_phone
  #   t.string :secondary_phone
  #   t.string :fax
  #   t.string :email
  #   t.string :street_address
  #   t.string :city
  #   t.string :neighborhood
  #   t.string :state
  #   t.references :country, index: true
  #   t.string :tax_no
  #   t.string :website
  #   t.text :notes
  #   t.timestamps
  ## distinct Organization fields
  #   t.string :alias
  #   t.references :primary_contact  #Person
  #   t.string :sector
  #   t.string :industry
  #   t.string :referral_source
  #   t.integer :organization_size
  #   t.integer :woman_ownership_percent
  #   t.integer :poc_ownership_percent
  #   t.integer :environmental_impact_score


  belongs_to :division
  belongs_to :country
  belongs_to :primary_contact, class_name: 'Person'

  has_many :loans   #, dependent: :destroy  - should probably require associated loans to be explicitly deleted
  has_many :people, foreign_key: :primary_organization_id   #, dependent: :destroy  - should probably require associated people to be explicitly deleted

  validates :display_name, presence: true


  def name
    display_name
  end

  def loans_count
    loans.size
  end

  def active_loans
    loans.where({status_option_id: Loan::STATUS_ACTIVE})
  end

end