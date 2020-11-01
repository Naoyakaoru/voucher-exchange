class Voucher < ApplicationRecord
  belongs_to :user

  validates :name, :tax_id, :tel, :presence => { :message => "不能為空白" }
  validates :tax_id, length: { is: 8 }, uniqueness: true
  validates :serial, uniqueness: true
  validate :valid_tax_id
  
  before_create :create_serial

  private
  def create_serial
    self.serial = [*'a'..'z', *'A'..'Z', *0..9].sample(10).join
  end

  def valid_tax_id
    multiplier = [1, 2, 1, 2, 1, 2, 4, 1].freeze
    serial = tax_id.split('')

    multipled = serial.zip(multiplier).map{|x, y| x.to_i * y}
    multipled_reduced = multipled.map{|x|x.divmod(10).reduce(:+)}
    if multipled_reduced[6] == 10
      other_sum = multipled_reduced[0..5].reduce(:+)+multipled_reduced[7]
      if other_sum != 0 || other_sum+1 != 0
        errors.add(:tax_id, "您所填寫的統一編號有誤，請確認後重新輸入")
      end
    else
      if multipled_reduced.reduce(:+)%10 != 0
        errors.add(:tax_id, "您所填寫的統一編號有誤，請確認後重新輸入")
      end
    end
  end
end
