class LoansController < DivisionOwnedBaseController



  protected

  def clazz
    Loan
  end


  def item_params
    params.require(:loan).permit(
        :organization_id, :primary_agent_id, :secondary_agent_id, :representative_id,
        :name,
        :summary, :details,  # todo: support extra translations
        :status_option_id, :project_type_option_id,
        :loan_type_option_id, :public_level_option_id, :currency_id,
        :amount, :rate, :length_months, :projected_return,
        :signing_date, :first_payment_date, :first_interest_payment_date, :target_end_date,
        :organization_size, :woman_ownership_percent, :poc_ownership_percent, :environmental_impact_score
    )
  end

end



