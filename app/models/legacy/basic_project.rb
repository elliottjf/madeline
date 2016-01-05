module Legacy

class BasicProject < ActiveRecord::Base
  establish_connection :legacy
  include LegacyModel
  # include Legacy
  # attr_accessible :title, :body
end

end