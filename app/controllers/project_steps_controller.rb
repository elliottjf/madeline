class ProjectStepsController < BaseController


  def new
    @item = clazz.new(new_params)
    render 'common/new'
  end

  def create
    # create blank record first to avoid parental issues with translation records
    @item = clazz.create(new_params)
    data = item_params
    if @item.update(data)
      redirect_to item_path(@item)
    else
      render 'common/edit'
    end
  end

  protected

  def clazz
    ProjectStep
  end

  def item_params
    params.require(:project_step).
        permit(:project_id, :project_type,
               :scheduled_date, :completed_date, :is_finalized,
               :summary, :details)
  end

  def create_params
    params.require(:project_step).
        permit(:project_id, :project_type)
  end

  def new_params
    params.permit(:project_id, :project_type)
  end


end
