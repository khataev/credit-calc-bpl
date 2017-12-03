class CreateLoans < ActiveRecord::Migration[5.1]
  def change
    create_table :loans do |t|
      t.string :name
      t.timestamps
    end
  end
end
