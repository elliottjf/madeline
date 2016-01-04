module Legacy

class Division < ActiveRecord::Base

  establish_connection :legacy

  include LegacyModel

  # remove_method :super_division
  
  # has_many :subdivisions, class_name: 'Division', foreign_key: 'SuperDivision'
  # belongs_to :super_division, class_name: 'Division', foreign_key: 'SuperDivision'
  
  # attr_accessible :Country, :Name

  def migration_data
    data = {
        id: id,
        name: name,
        description: description
    }
    data
  end

  def migrate
    data = migration_data
    puts "#{data[:id]}: #{data[:name]}"
    ::Division.create(data)
  end


end

end
