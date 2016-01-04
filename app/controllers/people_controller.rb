class PeopleController < DivisionOwnedBaseController


  protected

  def clazz
    Person
  end


  def item_params
    params.require(:person)
        .permit(:dispay_name, :legal_name, :primary_phone, :secondary_phone, :fax, :email,
                :street_address, :neighborhood, :city, :state, :country,
                :tax_no, :website, :notes,
                :first_name, :last_name,
                :primary_organization, :primary_organization_id)
  end

end
