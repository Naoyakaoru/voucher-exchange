class Voucher < ApplicationRecord
  belongs_to :user

  validates :name, :tax_id, :tel, presence: true
  validates :serial, :tax_id, uniqueness: true

  before_create :create_serial

  private
  def create_serial
    self.serial = [*'a'..'z', *'A'..'Z', *0..9].sample(10).join
  end
end
