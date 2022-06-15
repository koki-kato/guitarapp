require 'rails_helper'

RSpec.describe User, type: :model do

  it "name と email を持ったユーザーを登録できること" do
    user = User.new(
      name: "John",
      email: "john@example.com",
      )
     # オブジェクトをexpectに渡す動作が有効であることを確認
     expect(user).to be_valid
  end

end