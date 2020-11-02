require 'rails_helper'

RSpec.describe User, type: :model do
  it "is valid with a email, password" do
    user = User.new(
      email: Faker::Internet.email,
      password: '123123'
    )
    expect(user).to be_valid
  end
end
