class LoansController < ApplicationController
  include ApplicationHelper



  def index
    @division = current_division
    @items = @division.loans.first(10)  ## todo: proper pagination
  end

  def show
    @item = Loan.find(params[:id])
  end


  def new
    @division = current_division
    @item = @division.loans.build
  end

  def create
    @division = current_division
    if @item = @division.loans.create()
      if @item.update(item_params)
        redirect_to loan_path(@item)
      else
        render 'edit'
      end
    else
      render 'new'
    end
  end


  def edit
    @item = Loan.find(params[:id])
  end

  def update
    @item = Loan.find(params[:id])

    if @item.update(item_params)
      redirect_to loan_path(@item)
    else
      render 'edit'
    end
  end

  def destroy
    @item = Loan.find(params[:id])
    @item.destroy

    redirect_to loans_path
  end

  private
    def item_params
      params.require(:loan).permit(:name, :summary, :details, :amount, :rate, :length_months)
    end
end



