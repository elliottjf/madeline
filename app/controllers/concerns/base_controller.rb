#todo: consider base class vs mixin
class BaseController < ApplicationController
  include ApplicationHelper

  def clazz
    raise "not implemented - clazz"
  end

  def index_path
    method = "#{models_underscore}_path".to_sym
    self.send(method)
  end

  def new_item_path
    method = "new_#{model_underscore}_path".to_sym
    self.send(method)
  end

  def item_path(item)
    if item
      method = "#{model_underscore}_path".to_sym
      self.send(method, item)
    else
      logger.warn {"unexpectedly missing item: #{item}"}
      index_path
    end
  end

  def edit_item_path(item)
    method = "edit_#{model_underscore}_path".to_sym
    self.send(method, item)
  end

  def model_name
    clazz.name
  end

  def models_name
    clazz.name.pluralize
  end

  def model_underscore
    clazz.name.underscore
  end

  def models_underscore
    clazz.name.underscore.pluralize
  end

  def model_sym
    clazz.name.underscore.to_sym
  end

  def set_left_nav_selection
    session[:left_nav_selection] = models_underscore
  end

  helper_method :index_path, :new_item_path, :item_path, :edit_item_path, :model_name, :models_name, :current_division

  # filter and convert submitted edit form params
  def update_attrs
    raise "not implemented - update_attrs"
  end

  # if assigned by sub controller, then use this data for the initial model create and then update as a second step.
  # needed to detail with dependent attributes like translations
  # this should return any data needed to pass validation
  def create_attrs
    []
  end


  def index
    set_left_nav_selection
    @items = clazz.paginate(page: params[:page], per_page: DEFAULT_PER_PAGE)
  end

  def show
    set_left_nav_selection
    @item = clazz.find(params[:id])
  end

  # def new
  #   @item = clazz.new
  #   render 'common/new'
  # end

  # def create
  #   @item = clazz.new(item_params)
  #   if @item.save
  #     redirect_to @item
  #   else
  #     render 'common/new'
  #   end
  # end

  def new
    @item = clazz.new(new_query_params)
    render 'common/new'
  end

  def create
    # create blank record first to avoid parental issues with translation records
    create_data = create_params
    if create_data.present?
      # the two step create flow
      @item = clazz.create(create_data)
      if @item.valid?
        full_data = update_params
        @item.update(full_data)
        if @item.valid?
          redirect_to @item
        else
          # was partially created, display 'edit' form with errors
          render 'common/edit'
        end
      else
        # initial save failed, redisplay 'new' form with errors
        render 'common/new'
      end
    else
      # the single step create flow
      full_data = update_params
      @item = clazz.create(full_data)
      if @item.valid?
        redirect_to @item
      else
        render 'common/new'
      end
    end
  end


  def edit
    @item = clazz.find(params[:id])
    render 'common/edit'
  end

  def update
    @item = clazz.find(params[:id])

    if @item.update(update_params)
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


  # full list of attributes which may be assigned from a form
  def update_params
    params.require(model_sym).permit(update_attrs)
  end

  # if a two stage model creations is needed because of dependent attributes, then these are the fields which should be included
  # in the initial create() call.  if empty, then update_params used for a single stage create() call
  def create_params
    params.require(model_sym).permit(create_attrs)
  end

  # new link querey params to be applied to a new model
  def new_query_params
    params.permit(create_attrs)
  end


  DEFAULT_PER_PAGE = 15

end
