class RepaymentsController < ApplicationController
  before_action :load_tranche, only: [:index, :create, :clear_repayments, :delete_last_repayment]

  def index
    @tranche_repaid = @tranche.repaid?
    @repayments = @tranche.repayments.ordered
  end

  def clear_repayments
    @tranche.repayments.destroy_all
    redirect_to tranch_repayments_path(@tranche)
  end

  def delete_last_repayment
    @repayment = @tranche.repayments.ordered.last
    redirect_to tranch_repayments_path(@tranche) if @repayment&.destroy
  end

  def create
    @repayment = @tranche.repayments.new repayment_params
    redirect_to tranch_repayments_path(@tranche) if @tranche.save
  end

  private

  def load_tranche
    @tranche = Tranche.find params[:tranch_id]
  end

  def repayment_params
    permitted_params = params.require(:repayment).permit(:repayment_type)
    permitted_params.merge(month_number: @tranche.repayments.count + 1)
  end
end
