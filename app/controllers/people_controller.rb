class PeopleController < DivisionOwnedBaseController


  protected

  def clazz
    Person
  end


  # def item_params
  #   params.require(:person)
  #       .permit(:dispay_name, :legal_name, :primary_phone, :secondary_phone, :fax, :email,
  #               :street_address, :neighborhood, :city, :state, :country, :country_id,
  #               :tax_no, :website, :notes,
  #               :first_name, :last_name,
  #               :primary_organization, :primary_organization_id, :division_id)
  # end


  # fields needed for initial model creation
  def create_attrs
    [:division_id, :first_name]
  end

  # full list of attributes which may be assigned from the form
  def update_attrs
    [:division_id, :first_name, :last_name,
     :dispay_name, :legal_name, :primary_phone, :secondary_phone, :fax, :email,
     :street_address, :neighborhood, :city, :state, :country, :country_id,
     :tax_no, :website, :notes,
     :primary_organization, :primary_organization_id
    ]
  end


end
