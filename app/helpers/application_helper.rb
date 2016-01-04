module ApplicationHelper

  def current_division
    logger.debug "current_division - params: #{params}"
    if params[:set_division_id]
      set_current_division_id(params[:set_division_id])
    end
    division_id = current_division_id
    division = Division.find_safe(division_id)
    unless division
      logger.warn "current_division_id: #{division_id} not found - resetting"
      session[:current_division_id] = nil
      division_id = current_division_id
      division = Division.find_safe(division_id)
      logger.error "unexpectedly unable to find default division id: #{division_id}"
    end
    division
  end

  def current_division_id
    unless session[:current_division_id]
      logger.info "new session - assigning default div id"
      division_id = default_division_id
      session[:current_division_id] = division_id
    end
    session[:current_division_id]
  end

  def default_division_id
    # todo: better default logic
    division_id = Division.first.id
  end

  def set_current_division_id(id)
    session[:current_division_id] = id
  end

  def division_select_data
    Division.all.map{|d| [d.name, d.id]}  #todo: cache this
  end

  def organization_select_options(selected)
    options_from_collection_for_select(current_division.accessible_organizations, :id, :display_name, selected)
  end

  def person_select_options(selected)
    options_from_collection_for_select(current_division.accessible_people, :id, :name, selected)
  end

  def country_select_options(selected)
    options_from_collection_for_select(Country.all, :id, :name, selected)
  end

  #todo: figure out if i can omit the model param since the form should already have a reference
  def select_country(f, model, name = 'country_id'.to_sym)
    f.select(name, country_select_options(model.send(name)), {include_blank: '---'})
  end


end
