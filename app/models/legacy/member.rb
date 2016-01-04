module Legacy

class Member < ActiveRecord::Base

  establish_connection :legacy

  include LegacyModel

  def migration_data
    data = {
        id: self.id,
        division_id: ::Division::ROOT_ID,
        primary_organization_id: cooperative_id,
        first_name: first_name,
        last_name: last_name,
        display_name: "#{first_name} #{last_name}",
        primary_phone: phone,
        street_address: address,
        city: city,
        country_id: Country.id_from_name(self.country),
        tax_no: national_id,
    }
    data
  end

  def migrate
    data = migration_data
    puts "#{data[:id]}: #{data[:display_name]}"
    ::Person.create(data)
  end
end

end
