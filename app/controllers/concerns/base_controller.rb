#todo: consider base class vs mixin
class BaseController < ApplicationController
  include ApplicationHelper

  def clazz
    raise "not implemented - clazz"
  end

  def index_path
    method = "#{clazz.name.underscore.pluralize}_path".to_sym
    self.send(method)
  end

  def new_item_path
    method = "new_#{clazz.name.underscore}_path".to_sym
    self.send(method)
  end

  def item_path(item)
    if item
      method = "#{clazz.name.underscore}_path".to_sym
      self.send(method, item)
    else
      logger.warn {"unexpectedly missing item: #{item}"}
      index_path
    end
  end

  def edit_item_path(item)
    method = "edit_#{clazz.name.underscore}_path".to_sym
    self.send(method, item)
  end

  def model_name
    clazz.name
  end

  def models_name
    clazz.name.pluralize
  end

  def set_left_nav_selection
    session[:left_nav_selection] = models_name.underscore
  end

  helper_method :index_path, :new_item_path, :item_path, :edit_item_path, :model_name, :models_name, :current_division

  # filter and convert submitted edit form params
  def item_params
    raise "not implemented - item_params"
  end

  # if defined by sub controller, then use this data for the initial model create and then update as a second step.
  # needed to detail with dependent attributes like translations
  # this should return any data needed to pass validation
  def create_params
    nil
  end


  def index
    set_left_nav_selection
    @items = clazz.paginate(page: params[:page], per_page: DEFAULT_PER_PAGE)
  end

  def show
    set_left_nav_selection
    @item = clazz.find(params[:id])
  end

  def new
    @item = clazz.new
    render 'common/new'
  end

  def create
    @item = clazz.new(item_params)
    if @item.save
      redirect_to @item
    else
      render 'common/new'
    end
  end

  def edit
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


  DEFAULT_PER_PAGE = 15

end
