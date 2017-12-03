class ChangeTypeInRepayments < ActiveRecord::Migration[5.1]
  def change
    rename_column :repayments, :type, :repayment_type
  end
end
