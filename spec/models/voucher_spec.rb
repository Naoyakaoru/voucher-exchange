require 'rails_helper'

RSpec.describe Voucher, type: :model do
  let(:user) do #set a valid user
    User.create(
      email: Faker::Internet.email,
      password: '123123'
    )
  end

  describe 'validation when create' do
    context 'with a name, tax_id(rules followed), tel' do
      it 'should be valid' do
        voucher = user.vouchers.new(
          name: Faker::Company.name,
          tax_id: '54191940',
          tel: Faker::PhoneNumber.phone_number 
        )
        expect(voucher).to be_valid
      end
    end
    context 'with a name, tax_id(7th number is 7), tel' do
      it 'should be valid' do
        voucher = user.vouchers.new(
          name: Faker::Company.name,
          tax_id: '54178279',
          tel: Faker::PhoneNumber.phone_number 
        )
        expect(voucher).to be_valid
      end
    end
    context 'with a name, tax_id(7th number is 7), tel' do
      it 'should be valid' do
        voucher = user.vouchers.new(
          name: Faker::Company.name,
          tax_id: '54178278',
          tel: Faker::PhoneNumber.phone_number 
        )
        expect(voucher).to be_valid
      end
    end
    context 'with a name, tax_id(rules not followed), tel' do
      it 'should not be valid' do
        voucher = user.vouchers.new(
          name: Faker::Company.name,
          tax_id: '11111111',
          tel: Faker::PhoneNumber.phone_number 
        )
        expect(user).not_to be_valid
        expect(voucher.errors[:tax_id]).to include("您所填寫的統一編號有誤，請確認後重新輸入")
      end
    end
    context 'with a valid name, valid tax_id, blank tel' do
      it 'should not be valid' do
        voucher = user.vouchers.new(
          name: Faker::Company.name,
          tax_id: '54191940',
          tel: '' 
        )
        expect(user).not_to be_valid
        expect(voucher.errors[:tel]).to include("聯絡電話不能為空白")
      end
    end
    context 'with a valid name, 7 digit tax_id, valid tel' do
      it 'should not be valid' do
        voucher = user.vouchers.new(
          name: Faker::Company.name,
          tax_id: '5419194',
          tel: Faker::PhoneNumber.phone_number 
        )
        expect(user).not_to be_valid
        expect(voucher.errors[:tax_id]).to include("統一編號請輸入8碼數字")
      end
    end
    context 'with a valid name, 9 digit tax_id, valid tel' do
      it 'should not be valid' do
        voucher = user.vouchers.new(
          name: Faker::Company.name,
          tax_id: '541919401',
          tel: Faker::PhoneNumber.phone_number 
        )
        expect(user).not_to be_valid
        expect(voucher.errors[:tax_id]).to include("統一編號請輸入8碼數字")
      end
    end
    context 'with a valid name, blank tax_id, valid tel' do
      it 'should not be valid' do
        voucher = user.vouchers.new(
          name: Faker::Company.name,
          tax_id: '',
          tel: Faker::PhoneNumber.phone_number 
        )
        expect(user).not_to be_valid
        expect(voucher.errors[:tax_id]).to include("統一編號不能為空白")
      end
    end
    context 'with tax_id already taken' do
      it 'should not be valid' do
        voucher1 = user.vouchers.create(
          name: Faker::Company.name,
          tax_id: '89550029',
          tel: Faker::PhoneNumber.phone_number 
        )
        voucher2 = user.vouchers.new(
          name: Faker::Company.name,
          tax_id: '89550029',
          tel: Faker::PhoneNumber.phone_number 
        )
        expect(voucher1).to eq(Voucher.last)
        expect(voucher2).not_to be_valid
      end
    end
    context 'with a blank name, valid tax_id, valid tel' do
      it 'should not be valid' do
        voucher = user.vouchers.new(
          name: '',
          tax_id: '89550029',
          tel: Faker::PhoneNumber.phone_number 
        )
        expect(user).not_to be_valid
        expect(voucher.errors[:name]).to include("公司名稱不能為空白")
      end
    end

    describe 'coupon create in db' do
      context 'with valid name, tax_id, tel' do
        it 'should save in db' do
          voucher = user.vouchers.create(
            name: Faker::Company.name,
            tax_id: '89550029',
            tel: Faker::PhoneNumber.phone_number 
          )
          expect(voucher).to eq(Voucher.last)
        end
      end
    end
  end
end
