class CreateTranches < ActiveRecord::Migration[5.1]
  def change
    create_table :tranches do |t|
      t.references :loan, foreign_key: true
      t.decimal :amount
      t.integer :term
      t.decimal :base_rate
      t.decimal :overdue_rate
      t.decimal :monthly_main_debt_payment
      t.decimal :monthly_percent_payment
      t.decimal :monthly_total_payment
      t.decimal :total_to_pay
      t.decimal :percent_repaid
      t.decimal :main_debt_repaid
      t.decimal :real_rate

      t.timestamps
    end
  end
end
