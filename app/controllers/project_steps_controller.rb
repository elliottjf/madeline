class ProjectStepsController < BaseController


  protected

  def clazz
    ProjectStep
  end


  # fields needed for initial model creation
  def create_attrs
    [:project_id, :project_type]
  end

  def update_attrs
    [:project_id, :project_type, :scheduled_date, :completed_date, :is_finalized, :summary, :details]
  end



end
