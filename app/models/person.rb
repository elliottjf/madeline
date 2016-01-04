class Person < ActiveRecord::Base
  #todo: factor out base Contact class

  # create_table :people do |t|
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
  #   t.references :country
  #   t.string :tax_no
  #   t.string :website
  #   t.text :notes
  #   t.timestamps
  ## distinct Person fields
  #   t.string :first_name
  #   t.string :last_name
  #   t.references :primary_organization, index: true
  #


  belongs_to :division
  belongs_to :country
  belongs_to :primary_organization, class_name: 'Organization'

  has_many :primary_agent_loans,   class_name: 'Loan', foreign_key: :primary_agent_id
  has_many :secondary_agent_loans, class_name: 'Loan', foreign_key: :secondary_agent_id
  has_many :representative_loans,  class_name: 'Loan', foreign_key: :representative_id


  validates :division_id, presence: true
  validates :first_name, presence: true


  #todo: update to honor 'display_name' once that logic is properly incorporated
  def name
    "#{first_name} #{last_name}"
  end

end
