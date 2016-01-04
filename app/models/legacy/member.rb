module Legacy

class Member < ActiveRecord::Base

  establish_connection "legacy_#{Rails.env}"

  include LegacyModel

end

end
