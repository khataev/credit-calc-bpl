class AddColumnsToRepayments < ActiveRecord::Migration[5.1]
  def change
    add_column :repayments, :main_debt, :decimal, default: 0
    add_column :repayments, :percent, :decimal, default: 0
    rename_column :repayments, :amount, :total_amount
    change_column :repayments, :total_amount, :decimal, default: 0

    change_column :tranches, :percent_repaid, :decimal, default: 0
    change_column :tranches, :main_debt_repaid, :decimal, default: 0
  end
end
