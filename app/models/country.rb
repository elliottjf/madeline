class Country < ActiveRecord::Base

  # create_table :countries do |t|
  #   t.string :name
  #   t.string :code
  #   t.references :default_language
  #   t.references :default_currency
  #   t.timestamps

  belongs_to :default_language, class_name: 'Language'
  belongs_to :default_currency, class_name: 'Currency'

  # todo use cached map
  def self.id_from_name(name)
    Country.where(name: name).pluck(:id).first
  end

end
