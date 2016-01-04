#todo: consider base class vs mixin
class BaseController < ApplicationController
  include ApplicationHelper

  def clazz
    raise "not implemented - clazz"
  end

  def index_path
    method = "#{clazz.name.downcase.pluralize}_path".to_sym
    self.send(method)
  end

  def new_item_path
    method = "new_#{clazz.name.downcase}_path".to_sym
    self.send(method)
  end

  def item_path(item)
    method = "#{clazz.name.downcase}_path".to_sym
    self.send(method, item)
  end

  def edit_item_path(item)
    method = "edit_#{clazz.name.downcase}_path".to_sym
    self.send(method, item)
  end

  def model_name
    clazz.name
  end

  def models_name
    clazz.name.pluralize
  end

  helper_method :index_path, :new_item_path, :item_path, :edit_item_path, :model_name, :models_name, :current_division

  # filter and convert submitted edit form params
  def item_params
    raise "not implemented - item_params"
  end


  def show
    @item = clazz.find(params[:id])
  end

  def edit
    # @division = current_division
    @item = clazz.find(params[:id])
    render 'common/edit'
  end

  def update
    @item = clazz.find(params[:id])

    if @item.update(item_params)
      redirect_to item_path(@item)
    else
      render 'common/edit'
    end
  end

  def destroy
    @item = clazz.find(params[:id])
    @item.destroy

    redirect_to index_path
  end


end