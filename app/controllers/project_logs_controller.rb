class ProjectLogsController < BaseController

  protected

  def clazz
    ProjectLog
  end


  # fields needed for initial model creation
  def create_attrs
    [:project_step_id, :person_id]
  end

  # full list of attributes which may be assigned from the form
  def update_attrs
    [:project_step_id, :person_id, :progress_metric_option_id, :date,
     :summary, :details, :additional_notes, :private_notes  # translatable
    ]
  end


end
