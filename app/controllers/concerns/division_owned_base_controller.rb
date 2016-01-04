
#todo: this can be better factored

class DivisionOwnedBaseController < BaseController

  def division_relation(division)
    method = clazz.name.downcase.pluralize.to_sym
    division.send(method)
  end


  def index
    @division = current_division
    @items = division_relation(@division).first(10)  ## todo: proper pagination
  end

  def new
    @division = current_division
    @item = division_relation(@division).build
    render 'common/new'
  end

  def create
    @division = current_division
    if @item = division_relation(@division).create()
      if @item.update(item_params)
        redirect_to item_path(@item)
      else
        render 'common/edit'
      end
    else
      render 'common/new'
    end
  end



end