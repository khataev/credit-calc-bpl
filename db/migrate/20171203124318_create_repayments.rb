class CreateRepayments < ActiveRecord::Migration[5.1]
  def change
    create_table :repayments do |t|
      t.references :tranche, foreign_key: true
      t.integer :month_number
      t.decimal :amount
      t.integer :type

      t.timestamps
    end
  end
end
