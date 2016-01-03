class Loan < ActiveRecord::Base
  include ::Translatable

  #create_table :loans do |t|
  #  t.string :name
  #  t.decimal :amount, precision: 12, scale: 2
  #  t.decimal :rate, precision: 8, scale: 4
  #  t.integer :length_months
  #  t.references :division, index: true
  #
  #  t.timestamps

  belongs_to :division


  # define accessor like convenience methods for the fields stored in the Translations table
  attr_translatable :summary, :details


end
