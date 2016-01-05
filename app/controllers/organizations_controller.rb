class OrganizationsController < DivisionOwnedBaseController


  protected

  def clazz
    Organization
  end



  # def item_params
  #   params.require(:organization)
  #       .permit(:display_name, :legal_name, :primary_phone, :secondary_phone, :fax, :email,
  #               :street_address, :neighborhood, :city, :state, :country, :country_id,
  #               :tax_no, :website, :notes,
  #               :alias, :sector, :industry, :referral_source,
  #               :organization_size, :woman_ownership_percent, :poc_ownership_percent, :environmental_impact_score,
  #               :primary_contact, :primary_contact_id, :division_id)
  # end


  # fields needed for initial model creation
  def create_attrs
    [:division_id, :display_name]
  end

  # full list of attributes which may be assigned from the form
  def update_attrs
    [:division_id, :display_name,
     :primary_contact, :primary_contact_id,
     :legal_name, :primary_phone, :secondary_phone, :fax, :email,
     :street_address, :neighborhood, :city, :state, :country, :country_id,
     :tax_no, :website, :notes,
     :alias, :sector, :industry, :referral_source,
     :organization_snapshot_id,
     # :organization_size, :woman_ownership_percent, :poc_ownership_percent, :environmental_impact_score,  #todo: move to separate model
    ]
  end



  end
