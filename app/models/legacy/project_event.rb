module Legacy

class ProjectEvent < ActiveRecord::Base
  establish_connection :legacy
  include LegacyModel
  # include Legacy, TranslationModule

  belongs_to :member, :foreign_key => 'MemberID'
  # has_many :project_logs, :foreign_key => 'PasoID'
  alias_attribute :logs, :project_logs
  # attr_accessible :Completed, :Date, :Details, :Finalized, :ProjectID, :ProjectTable, :Summary, :Type

  def project
    project_table_model = Object.const_get(self.project_table.classify)
    project_table_model.find(self.project_id)
  end

  def completed_or_not
    self.completed ? 'completed' : 'not_completed'
  end

  def status
    if self.completed
      I18n.t :log_completed
    else
      project_logs.order("Date").last.try(:progress)
    end
  end

  def summary
    self.translation('Summary')
  end
  def details
    self.translation('Details')
  end

  def display_date
    I18n.l (self.completed || self.date), format: :long
  end


  def migration_data
    data = {
        id: self.id,
        project_type: project_table.singularize.capitalize,
        project_id: project_id,
        person_id: member_id,
        scheduled_date: date,
        completed_date: completed,
        is_finalized: finalized,
        type_option_id: ::ProjectStep::MIGRATION_TYPE_OPTIONS.value_for(type),
    }
    data
  end

  def migrate
    data = migration_data
    puts "#{data[:id]}: #{data[:project_id]}"
    ::ProjectStep.create(data)
  end

end

end
