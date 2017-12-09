class LoansController < ApplicationController
  before_action :load_loan, only: [:edit, :destroy]

  def index
    respond_with(@loans = Loan.all)
  end

  def new
    respond_with(@loan = Loan.new)
  end

  def edit
  end

  def destroy
    @loan.destroy
    redirect_to :loans, notice: 'Займ удален'
  end

  def create
    @loan = Loan.new(loan_params)
    if @loan.save!
      redirect_to :loans, notice: 'Займ создан'
    else
      render action: :new
    end
  end

  private

  def load_loan
    @loan = Loan.find params[:id]
  end

  def loan_params
    params.require(:loan).permit(:name)
  end
end
