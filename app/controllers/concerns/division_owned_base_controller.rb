
#todo: this can be better factored

class DivisionOwnedBaseController < BaseController

  ## todo: rename this.  it's not a proper relation object, but a view of accessible data
  def division_relation(division)
    # method = clazz.name.downcase.pluralize.to_sym
    method = "accessible_#{clazz.name.downcase.pluralize}".to_sym
    division.send(method)
  end


  def index
    set_left_nav_selection
    @division = current_division
    @items = division_relation(@division).paginate(page: params[:page], per_page: DEFAULT_PER_PAGE)
  end

  def new
    @division = current_division
    data = new_query_params
    data[:division_id] = @division.id
    @item = clazz.new(data)
    #todo: consider putting division into new link
    render 'common/new'
  end

  # def create
  #   @division = current_division
  #   logger.debug("division: #{@division.inspect}")
  #   data = item_params
  #   # logger.debug("data: #{data}")
  #   @item = clazz.create(data)
  #   # logger.debug("created item: #{@item.inspect}")
  #   # logger.debug("item valid?: #{@item.valid?}")
  #   if @item.valid?
  #     redirect_to item_path(@item)
  #   else
  #     render 'common/new'
  #   end
  # end



end
