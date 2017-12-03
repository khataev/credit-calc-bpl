class AddOverdueParamsToTranche < ActiveRecord::Migration[5.1]
  def change
    add_column :tranches, :monthly_overdue_percent_payment, :decimal
    add_column :tranches, :monthly_overdue_total_payment, :decimal
  end
end
