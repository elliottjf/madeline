class OrganizationsController < DivisionOwnedBaseController


  protected

  def clazz
    Organization
  end



  def item_params
    params.require(:organization)
        .permit(:display_name, :legal_name, :primary_phone, :secondary_phone, :fax, :email,
                :street_address, :neighborhood, :city, :state, :country, :country_id,
                :tax_no, :website, :notes,
                :alias, :sector, :industry, :referral_source,
                :organization_size, :woman_ownership_percent, :poc_ownership_percent, :environmental_impact_score,
                :primary_contact, :primary_contact_id, :division_id)
  end


end
