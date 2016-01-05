class Division < ActiveRecord::Base
  # include ::Translatable

  #create_table :divisions do |t|
  #  t.string :name
  #  t.text :description
  #  t.references :parent #Division
  #  t.references :default_currency
  #
  #  t.timestamps

  has_many :loans   #, dependent: :destroy  - should probably require owned models to be explicitly deleted
  has_many :people
  has_many :organizations


  belongs_to :parent, class_name: 'Division'
  belongs_to :default_currency, class_name: 'Currency'

  validates :name, presence: true


  def root?
    id == Division::ROOT_ID
  end

  def accessible_organizations
    # for now hack access to current or root division owned entities
    if root?
      Organization.all
    else
      Organization.where(division_id: [id, Division::ROOT_ID]).order(:display_name)
    end
  end

  def accessible_people
    # for now hack access to current or root division owned entities
    if root?
      Person.all
    else
      Person.where(division_id: [id, Division::ROOT_ID]).order(:last_name)
    end
  end

  def accessible_loans
    if root?
      Loan.all
    else
      Loan.where(division_id: [id, Division::ROOT_ID]).order(signing_date: :desc)
    end
  end

  def loans_count
    loans.size
  end

  ROOT_ID = 99

end
