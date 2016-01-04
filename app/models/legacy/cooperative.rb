module Legacy

class Cooperative < ActiveRecord::Base

  establish_connection :legacy

  include LegacyModel

  # attr_accessible :Name
  # has_many :loans, :foreign_key => 'CooperativeID'

  def verbose_name
    @verbose_name ||= (self.name =~ /#{I18n.t :cooperative}/i) ? self.name : I18n.t(:cooperative_name, name: self.name)
  end

  def migration_data
    data = {
        id: self.id,
        division_id: ::Division::ROOT_ID,
        display_name: name,
        legal_name: nombre_legal_completo,
        primary_phone: telephone,
        email: email,
        street_address: address,
        city: city,
        neighborhood: borough,
        state: state,
        country_id: Country.id_from_name(self.country),
        tax_no: tax_id,
        #todo: figure out why this bombs, perhaps because source column is already lower case
        #website: web,
        alias: self.alias,
        ##todo: is_recovered: recuperada,
        sector: sector,
        industry: industry,
        referral_source: source,
    }
    data
  end

  def migrate
    data = migration_data
    puts "#{data[:id]}: #{data[:display_name]}"
    ::Organization.create(data)
  end

end

end
