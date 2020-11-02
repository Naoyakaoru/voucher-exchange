require 'rails_helper'

RSpec.describe Voucher, type: :model do
  it "is valid with a name, tax_id(rules followed), tel" do
    user = User.new(
      email: Faker::Internet.email,
      password: '123123'
    )
    voucher1 = user.vouchers.new(
      name: Faker::Company.name,
      tax_id: '54191940',
      tel: Faker::PhoneNumber.phone_number 
    )
    voucher2 = user.vouchers.new(
      name: Faker::Company.name,
      tax_id: '54178279', #第7碼為7
      tel: Faker::PhoneNumber.phone_number 
    )
    expect(voucher1).to be_valid
    expect(voucher2).to be_valid
  end

  it "is invalid with a rules not followed tax_id" do
    user = User.new(
      email: Faker::Internet.email,
      password: '123123'
    )
    voucher1 = user.vouchers.new(
      name: Faker::Company.name,
      tax_id: '',
      tel: Faker::PhoneNumber.phone_number 
    )
    voucher2 = user.vouchers.new(
      name: Faker::Company.name,
      tax_id: '11111111',
      tel: Faker::PhoneNumber.phone_number 
    )
    voucher3 = user.vouchers.new(
      name: Faker::Company.name,
      tax_id: '1111',
      tel: Faker::PhoneNumber.phone_number 
    )
    voucher1.valid?
    voucher2.valid?
    voucher3.valid?
    expect(voucher1.errors[:tax_id]).to include("統一編號不能為空白")
    expect(voucher2.errors[:tax_id]).to include("您所填寫的統一編號有誤，請確認後重新輸入")
    expect(voucher3.errors[:tax_id]).to include("統一編號請輸入8碼數字")
  end
  it "is invalid if tax_id is already taken" do
    user = User.new(
      email: Faker::Internet.email,
      password: '123123'
    )
    voucher1 = user.vouchers.new(
      name: Faker::Company.name,
      tax_id: '54191940',
      tel: Faker::PhoneNumber.phone_number 
    )
    voucher2 = user.vouchers.new(
      name: Faker::Company.name,
      tax_id: '54191940',
      tel: Faker::PhoneNumber.phone_number 
    )
    voucher1.valid?
    voucher2.valid?
    expect(voucher1).to be_valid
    expect(voucher2.errors[:tax_id]).to eq([]) #錯誤寫在controller
  end
end
