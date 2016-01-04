module Legacy

class Cooperative < ActiveRecord::Base

  establish_connection "legacy_#{Rails.env}"

  include LegacyModel

  attr_accessible :Name
  has_many :loans, :foreign_key => 'CooperativeID'

  def verbose_name
    @verbose_name ||= (self.name =~ /#{I18n.t :cooperative}/i) ? self.name : I18n.t(:cooperative_name, name: self.name)
  end
end

end
