require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'create validates' do
    context 'create with email, password' do
      it "is not valid with email, password with 5 letters" do
        user = User.new(
        email: Faker::Internet.email,
        password: '12312'
        )
        expect(user).not_to be_valid
        expect(user.errors[:password]).to include('is too short (minimum is 6 characters)')
      end

      it "is valid with email, password with 6 letters" do
        user = User.new(
          email: Faker::Internet.email,
          password: '123123'
          )
          expect(user).to be_valid
      end

      it "is valid with email, password with 7 letters" do
        user = User.new(
          email: Faker::Internet.email,
          password: '1231231'
          )
          expect(user).to be_valid
      end
    end
    context 'create with email, without password' do
      it "is should not be valid" do
        user = User.new(
        email: Faker::Internet.email,
        password: ''
        )
        expect(user).not_to be_valid
        expect(user.errors[:password]).to include("can't be blank")
      end
    end
    context 'create without email, with valid password' do
      it "is should not be valid" do
        user = User.new(
        email: '',
        password: '123123'
        )
        expect(user).not_to be_valid
        expect(user.errors[:email]).to include("can't be blank")
      end
    end
    context 'create with invalid email, enough length password' do
      it "is should not be valid" do
        user = User.new(
        email: 'ewqer',
        password: '123123'
        )
        expect(user).not_to be_valid
        expect(user.errors[:email]).to include("is invalid")
      end
    end
  end
  describe 'create in model' do
    context 'created with valid email and password' do
      it 'should create user' do
        user = User.create(
          email: Faker::Internet.email,
          password: '123123'
          )
          expect(user).to eq(User.last)
      end
    end
  end
end
