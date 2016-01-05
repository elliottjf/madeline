class DivisionsController < BaseController

  protected

  def clazz
    Division
  end

  # def item_params
  #   params.require(:division).permit(:name, :description)
  # end

  def update_attrs
    [:name, :description]
  end


  end
