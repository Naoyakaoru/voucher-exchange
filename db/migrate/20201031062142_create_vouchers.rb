class CreateVouchers < ActiveRecord::Migration[6.0]
  def change
    create_table :vouchers do |t|
      t.string :name
      t.string :tax_id
      t.string :tel

      t.timestamps
    end
  end
end
