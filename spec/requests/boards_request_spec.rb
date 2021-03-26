require 'rails_helper'

RSpec.describe "Boards", type: :request do

  describe "boards/#create" do
    before do
      @user = FactoryBot.create(:user)
      @board = FactoryBot.attributes_for(:board)
      @board[:user_id] = @user.id
    end

    context '新規登録ができる' do
      it 'ボードが登録する' do
        post sign_in_path, params: {user: {email: @user.email, password: @user.password}},xhr: true
        expect(response).to have_http_status(200)
        post boards_path, params: {board: @board}, xhr: true
        res = JSON.parse(response.body)
        res.each do |data|
          expect(data["name"]).to include(@board[:name])
        end
      end
    end

    context '新規登録ができない場合' do
      it 'ボードの名前が存在しない場合' do
        post sign_in_path, params: {user: {email: @user.email, password: @user.password}},xhr: true
        expect(response).to have_http_status(200)
        @board[:name] = ""
        post boards_path, params: {board: @board}, xhr: true
        res = JSON.parse(response.body)
        expect(res["errors"]).to include("ボードの名前を入力してください。")
      end

      it 'ユーザーidが存在しない場合' do
        @board[:user_id] = nil
        post boards_path, params: {board: @board}, xhr: true
        res = JSON.parse(response.body)
        expect(res["errors"]).to include("ログインしてください")
      end
    end
  end

  describe 'boards/#update' do
    before do
      @user = FactoryBot.create(:user)
      @board = FactoryBot.create(:board)
      @board.user_id = @user.id
    end

    context 'ボードの更新ができる場合' do 
      it '更新に成功する' do
        post sign_in_path, params: {user: {email: @user.email, password: @user.password}},xhr: true
        expect(response).to have_http_status(200)
        @board[:name] = "updated"
        patch "/boards/#{@board.id}", params: {board: {id: @board.id, name: @board.name, user_id: @user.id}}, xhr: true
        res = JSON.parse(response.body)
        res.each do |data|
          expect(data["name"]).to include(@board.name)
        end
      end
    end

    context '更新に失敗する' do
      it 'ボードの名前の入力がない' do
        post sign_in_path, params: {user: {email: @user.email, password: @user.password}},xhr: true
        expect(response).to have_http_status(200)
        @board[:name] = ""
        patch "/boards/#{@board.id}", params: {board: {id: @board.id, name: @board.name, user_id: @user.id}}, xhr: true
        res = JSON.parse(response.body)
      end

      it 'ユーザーidが存在しない' do
        @board.user_id = nil
        patch "/boards/#{@board.id}", params: {board: {id: @board.id, name: @board.name, user_id: @board.user_id}}, xhr: true
        res = JSON.parse(response.body)
        expect(res["errors"]).to include("ログインしてください。")
      end
    end
  end 

  describe 'boards/#select' do
    before do
      @board = FactoryBot.create(:board)
    end

    context 'ボードの取得に成功する場合' do
      it 'ボードが取得できる' do
        get "/boards/#{@board.id}/select", params: {id: @board.id}, xhr: true
        res = JSON.parse(response.body)
        expect(res["id"]).to eq @board.id
      end
    end
  end
end