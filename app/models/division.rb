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


  def loans_count
    loans.size
  end

end
