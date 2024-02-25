require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できる場合' do
      it "nameとemail、passwordとpassword_confirmationが存在すれば登録できる" do
        expect(@user).to be_valid
      end
    end
    context '新規登録できない場合' do
      it "nameが空では登録できない" do
        @user.name = ''
        expect(@user).to_not be_valid
      end
      it "emailが空では登録できない" do
        @user.email = ''
        expect(@user).to_not be_valid
      end
      it "passwordが空では登録できない" do
        @user.password = ''
        expect(@user).to_not be_valid
      end
      it 'passwordが5文字以下では登録できない' do
        @user.password = 'ooooo'
        expect(@user).to_not be_valid
      end
      it 'passwordが129文字以上では登録できない' do
        @user.password =  Faker::Internet.password(min_length: 129, max_length: 150)
        expect(@user).to_not be_valid
      end
      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '234567'
        expect(@user).to_not be_valid
      end
      it '重複したemailが存在する場合は登録できない' do
        FactoryBot.create(:user, email: @user.email)
        expect(@user).to_not be_valid
      end
      it 'emailは@を含まないと登録できない' do
        @user.email = '1234fvjumail'
        expect(@user).to_not be_valid
      end
    end
  end
end