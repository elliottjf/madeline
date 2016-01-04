class WelcomeController < ApplicationController
  include ApplicationHelper


  def index
    logger.debug "Rails.root: #{Rails.root}"
    logger.debug "welcome index"
    # @division = current_division
    # @loans = @division.loans
    redirect_to selected_nav_path
  end

  def select_division
    logger.info "select_division - params: #{params}"
    set_current_division_id(params["division_id"])
    # redirect_to root_path
    redirect_to selected_nav_path
  end
end


