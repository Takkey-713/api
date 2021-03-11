require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  context 'ユーザー登録に成功する' do
    it '全てのデータが入力される' do
      @user.valid? 
      expect(@user.valid?).to eq true
    end
  end

  context 'ユーザー登録ができない場合' do
    it "emailが空の場合" do
      @user.email = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it "@がない場合に登録ができない" do
      @user.email = "testusergmail.com"
      @user.valid?
      expect(@user.errors.full_messages).to include("Email is invalid")
    end

    it "メールアドレスの一意性を検証" do 
      @user.save
      another_user = FactoryBot.build(:user)
      another_user.valid?
      expect(another_user.errors.full_messages).to include("Email has already been taken")
    end

    it "不正な値が入力された場合" do
      @user.email = "テスト@gmail.com"
      @user.valid?
      expect(@user.errors.full_messages).to include("Email is invalid")
    end 

    it "パスワードが空の入力の場合" do
      @user.password = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end
    
    it "パスワードが確認用パスワードと一致しない場合" do
      @user.password = "test1111"
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it "確認用パスワードがパスワードと一致しない場合" do
      @user.password_confirmation = "ytes44444"
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it "パワワードが6文字未満の場合" do
      @user.password, @user.password_confirmation = "test1", "test1"
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end

    it "パスワードが20文字より大きくなる場合" do
      @user.password, @user.password_confirmation = "ttttttttttttttttttttttttttttt11111", "ttttttttttttttttttttttttttttt11111"
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is too long (maximum is 20 characters)")
    end

    it "パスワードが数字のみの場合" do
      @user.password , @user.password_confirmation = "11111111", "11111111"
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is invalid")
    end
    
    it "パスワードが半角英語のみの場合" do 
      @user.password , @user.password_confirmation = "abcdefgh", "abcdefgh"
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is invalid")
    end

    it "パスワードが全角で入力された場合" do
      @user.password, @user.password_confirmation = "パスワード", "パスワード"
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is invalid")
    end
  end
end
