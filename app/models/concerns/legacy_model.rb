# Methods and declarations for dealing with legacy database
# Include in models referring to tables created outside of rails. Tables generated by rails follow rails conventions.
module LegacyModel
  extend ActiveSupport::Concern

  # Datetime fields to convert to date fields (times are not used - all are set to midnight)
  DATE_FIELDS = %w(Date DateDue DatePaid)

  included do
    # tell rails to look for table name in CamelCase instead of default under_score
    self.table_name = self.table_name.camelize

    # default primary key
    self.primary_key = 'ID'

    # make CamelCase column names accessible as under_score
    column_names.each do |col|
      if col.in? DATE_FIELDS
        # Convert datetimes to date
        define_method(col.underscore) { send(col).try(:to_date) }
      else
        alias_attribute col.underscore, col
      end
    end
  end
end
