class VoucherBelongsToUser < ActiveRecord::Migration[6.0]
  def change
    add_reference :vouchers, :user, index: true
  end
end
