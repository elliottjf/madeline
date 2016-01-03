module ApplicationHelper

  def current_division
    logger.debug "current_division - params: #{params}"
    if params[:set_division_id]
      set_current_division_id(params[:set_division_id])
    end
    division_id = current_division_id
    @division = Division.find(division_id)
  end

  def current_division_id
    unless session[:current_division_id]
      logger.info "new session - assigning default div id"
      division_id = Division.first.id
      session[:current_division_id] = division_id
    end
    session[:current_division_id]
  end

  def set_current_division_id(id)
    session[:current_division_id] = id
  end

  def division_select_data
    Division.all.map{|d| [d.name, d.id]}  #todo: cache this
  end

end
