class DivisionsController < BaseController

  def index
    set_left_nav_selection
    @items = Division.all
  end

  def new
    @item = Division.new
    render 'common/new'
  end

  def create
    @item = Division.new(item_params)
    if @item.save
      redirect_to @item
    else
      render 'common/new'
    end
  end


  protected

  def clazz
    Division
  end

  def item_params
    params.require(:division).permit(:name, :description)
  end

end
