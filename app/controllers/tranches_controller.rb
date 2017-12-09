class TranchesController < ApplicationController
  before_action :load_loan, only: [:new, :create]
  before_action :load_tranche, only: [:destroy, :update]

  respond_to :js, only: [:new, :create, :edit, :update]

  def new
    @tranche = @loan.tranches.new
  end

  def create
    @tranche = @loan.tranches.new tranche_params
    result = TrancheRepaymentCalcService.new(tranche: @tranche).call
    @tranche.assign_attributes result
    if @tranche.save
      redirect_to edit_loan_path(@loan)
    else
      render action: :new, tranche: @tranche
    end
  end

  def edit
  end

  def update
    result = TrancheRepaymentCalcService.new(tranche: @tranche).call
    @tranche.assign_attributes result
    if @tranche.save
      redirect_to edit_loan_path(@loan)
    else
      render action: :update, tranche: @tranche
    end
  end

  def destroy
    loan = @tranche.loan
    @tranche.destroy
    redirect_to edit_loan_path(loan), notice: 'Транш удален'
  end

  private

  def load_loan
    @loan = Loan.find params[:loan_id]
  end

  def tranche_params
    permitted_params = params.require(:tranche).permit(:amount, :term, :base_rate_percent, :overdue_rate_percent)
    permitted_params[:base_rate] = permitted_params[:base_rate_percent].to_f / 100 if permitted_params[:base_rate_percent].present?
    permitted_params[:overdue_rate] = permitted_params[:overdue_rate_percent].to_f / 100 if permitted_params[:overdue_rate_percent].present?
    permitted_params.reject { |k,v| %w[base_rate_percent overdue_rate_percent].include? k }
  end

  def load_tranche
    @tranche = Tranche.find params[:id]
  end
end
