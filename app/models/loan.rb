class Loan < ActiveRecord::Base
  include ::Translatable

  # create_table :loans do |t|
  #   ## base Project fields
  #   t.references :division, index: true
  #   t.references :organization, index: true
  #   t.string :name
  #   # translatable: summary
  #   # translatable: details
  #   t.references :primary_agent #Person
  #   t.references :secondary_agent #Person
  #   t.integer :status_option_id, index: true
  #   t.integer :project_type_option_id
  #   ## distinct Loan fields
  #   t.integer :loan_type_option_id, index: true
  #   t.integer :public_level_option_id, index: true
  #   t.decimal :amount, precision: 12, scale: 2
  #   t.references :currency
  #   t.decimal :rate, precision: 8, scale: 4
  #   t.integer :length_months
  #   t.references :representative  #Person
  #   t.date :signing_date
  #   t.date :first_payment_date
  #   t.date :first_interest_payment_date
  #   t.date :target_end_date
  #   t.decimal :projected_return, precision: 12, scale:2
  #   ## historical values captured from organization when loan created
  #   t.integer :organization_size
  #   t.integer :woman_ownership_percent
  #   t.integer :poc_ownership_percent
  #   t.integer :environmental_impact_score
  #
  #   t.timestamps

  belongs_to :division
  belongs_to :organization
  belongs_to :primary_agent,   class_name: 'Person'
  belongs_to :secondary_agent, class_name: 'Person'
  belongs_to :representative,  class_name: 'Person'
  belongs_to :currency


  # define accessor like convenience methods for the fields stored in the Translations table
  attr_translatable :summary, :details

  # todo: proper handling needs to be defined, probably a pre-populated and editable display name
  def name
    "Project with #{organization.try(:name)}"
  end

  def status
    STATUS_OPTIONS.label_for(status_option_id)
  end

  def loan_type
    LOAN_TYPE_OPTIONS.label_for(loan_type_option_id)
  end

  STATUS_ACTIVE = 1

  # STATUS_OPTIONS = OptionSet.new(
  #     [ [STATUS_ACTIVE, 'Active'],
  #       [2, 'Completed'],
  #       [3, 'Frozen'],
  #       [4, 'Liquidated'],
  #       [5, 'Prospective'],
  #       [6, 'Refinanced'],
  #       [7, 'Relationship'],
  #       [8, 'Relationship Active']
  #     ]
  # )

  STATUS_OPTIONS = OptionSet.new(
      [ [STATUS_ACTIVE, 'Prestamo Activo'],
        [2, 'Prestamo Completo'],
        [3, 'Prestamo Congelado'],
        [4, 'Prestamo Liquidado'],
        [5, 'Prestamo Prospectivo'],
        [6, 'Prestamo Refinanciado'],
        [7, 'Relacion'],
        [8, 'Relacion Activo']
      ]
  )

  LOAN_TYPE_OPTIONS = OptionSet.new(
      [ [1,"Liquidity line of credit"],
        [2,"Investment line of credit"],
        [3,"Investment Loans"],
        [4,"Evolving loan"],
        [5,"Single Liquidity line of credit"],
        [6,"Working Capital Investment Loan"],
        [7,"Secured Asset Investment Loan"]
      ]
  )

  PROJECT_TYPE_OPTIONS = OptionSet.new(
      [ [1,'Conversion'],
        [2,'Expansion'],
        [3,'Start-up'],
      ]
  )

  PUBLIC_LEVEL_OPTIONS = OptionSet.new(
      [ [1,'Featured'],
        [2,'Hidden'],
      ]
  )

  # STATUS_OPTIONS = OptionSet.new(
  #     [ [1, ['Active', 'Prestamo Activo']],
  #       [2, ['Completed', 'Prestamo Completo']],
  #       [3, ['Frozen', 'Prestamo Congelado']],
  #       [4, ['Liquidated', 'Prestamo Liquidado']],
  #       [5, ['Prospective','Prestamo Prospectivo']],
  #       [6, ['Refinanced', 'Prestamo Refinanciado']],
  #       [7, ['Relationship', 'Relacion']],
  #       [8, ['Relationship Active', 'Relacion Activo']]
  #     ]
  # )

end


