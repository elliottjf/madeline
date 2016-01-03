class DivisionsController < ApplicationController

  def index
    @items = Division.all
  end

  def show
    @item = Division.find(params[:id])
  end

  def new
    @item = Division.new
  end

  def edit
    @item = Division.find(params[:id])
  end

  def create
    @item = Division.new(item_params)
    if @item.save
      redirect_to @item
    else
      render 'new'
    end
  end

  def update
    @item = Division.find(params[:id])

    if @item.update(item_params)
      redirect_to @item
    else
      render 'edit'
    end
  end

  def destroy
    @item = Division.find(params[:id])
    @item.destroy

    redirect_to divisions_path
  end

  private
    def item_params
      params.require(:division).permit(:name, :description)
    end

end
