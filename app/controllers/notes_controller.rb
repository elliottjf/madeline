class NotesController < BaseController


  protected

  def clazz
    Note
  end


  # fields needed for initial model creation
  def create_attrs
    [:notable_type, :notable_id, :person_id]
  end

  def update_attrs
    [:notable_type, :notable_id, :person_id, :text]
  end


end
