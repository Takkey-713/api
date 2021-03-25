require 'rails_helper'

RSpec.describe "Auth", type: :request do
  

  describe "sign_up" do
    before do
      @user = FactoryBot.attributes_for(:user)
    end

    context '新規登録できる場合' do
      it '新規ユーザーを作成する' do
        expect { post sign_up_path, params: { user: @user }, xhr: true }.to change(User, :count).by(+1)
        expect(response.status).to eq 200
        res = JSON.parse(response.body) 
        expect(res["user"]["email"]).to eq @user[:email]
        # 一意のメールアドレスが一致するか確認
      end
    end

    context '新規登録ができない場合' do
      it "メールアドレスが既に登録されている場合" do
        user = FactoryBot.create(:user)
        @user[:email] = user[:email]
        post sign_up_path, params: { user: @user }, xhr: true 
        res = JSON.parse(response.body)
        expect(res["errors"]).to include("入力されたメールアドレスは既に登録されています。")
      end

      it "パスワードと確認パスワードと一致しない場合" do
        @user[:password] = "notsame123"
        post sign_up_path, params: { user: @user }, xhr: true 
        res = JSON.parse(response.body)
        expect(res["errors"]).to include("認証に失敗しました。")
      end

      it "メールアドレスが不正な場合" do
        @user[:password] = "notemaladress.com"
        post sign_up_path, params: { user: @user }, xhr: true 
        res = JSON.parse(response.body)
        expect(res["errors"]).to include("認証に失敗しました。")
      end
    end
  end

  describe "sign_in" do
    before do
      @user = FactoryBot.create(:user)
    end

    context 'ログインできる場合' do
      it 'ログインが成功する' do
        expect {post sign_in_path, params: {user: {email: @user.email, password: @user.password}}, xhr: true }.to change(User, :count).by(0)
        expect(response.status).to eq 200
        res = JSON.parse(response.body)
        expect(res["user"]["email"]).to eq @user[:email]
      end
    end

    context 'ログインできない場合' do
      it 'メールアドレスが一致しない場合' do
        post sign_in_path, params: {user: {email: "error@gmail.com", password: @user.password}}, xhr: true 
        res = JSON.parse(response.body)
        expect(res["errors"]).to include("メールアドレスまたはパスワードが正しくありません。")
      end
      
      it 'パスワードが一致しない場合' do
        post sign_in_path, params: {user: {email: @user.email, password: "nosame1245"}}, xhr: true 
        res = JSON.parse(response.body)
        expect(res["errors"]).to include("メールアドレスまたはパスワードが正しくありません。")
      end
      it 'メールアドレスが不正な場合' do
        post sign_in_path, params: {user: {email: "notsameemail.com", password: @user.password}}, xhr: true 
        res = JSON.parse(response.body)
        expect(res["errors"]).to include("メールアドレスまたはパスワードが正しくありません。")
      end
    end
  end

  describe "sign_out" do
    before do
      @user = FactoryBot.create(:user)
    end

    context 'サインアウトできる場合' do
      it 'サインアウトに成功する' do
        post sign_in_path, params: {user: {email: @user.email, password: @user.password}}, xhr: true
        expect(response).to have_http_status(200)
        delete sign_out_path, xhr: true
        res = JSON.parse(response.body)
        expect(res["logged_in"]).to eq false 
      end
    end
  end

end