class AddSerialNumberToVoucher < ActiveRecord::Migration[6.0]
  def change
    add_column :vouchers, :serial, :string, unique: true
  end
end
