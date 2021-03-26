require 'rails_helper'

RSpec.describe "Lists", type: :request do
  describe 'lists/#create' do
    before do
      @user = FactoryBot.create(:user)
      @board = FactoryBot.create(:board)
      @list = FactoryBot.attributes_for(:list)
      @list[:user_id], @list[:board_id] = @user.id, @board.id
    end

    context 'リストの新規登録ができる場合' do
      it 'リストの作成ができる' do
        post sign_in_path, params: {user: {email: @user.email, password: @user.password}},xhr: true
        expect(response).to have_http_status(200)
        post lists_path, params: {list: @list}, xhr: true
        res = JSON.parse(response.body)
        res.each do |data|
          expect(data["name"]).to include @list[:name]
        end
      end
    end

    context 'リストの新規作成ができない場合' do
      it 'リストの名前が存在しない場合' do
        post sign_in_path, params: {user: {email: @user.email, password: @user.password}},xhr: true
        expect(response).to have_http_status(200)
        @list[:name] = ""
        post lists_path, params: {list: @list}, xhr: true
        res = JSON.parse(response.body)
        expect(res["errors"]).to include("リストの名前を入力してください。")
      end

      it 'ユーザーidが存在しない場合' do
        @list[:user_id] = nil
        post lists_path, params: {list: @list}, xhr: true
        res = JSON.parse(response.body)
        expect(res["errors"]).to include("ログインしてください。")
      end

      it 'ボードidが存在しない' do
        @list[:board_id] = nil
        post sign_in_path, params: {user: {email: @user.email, password: @user.password}},xhr: true
        expect(response).to have_http_status(200)
        post lists_path, params: {list: @list}, xhr: true
        res = JSON.parse(response.body)
        expect(res["errors"]).to include("ボードを作成してください。")
      end
    end
  end

  describe 'lists/#update' do
    before do
      @list = FactoryBot.create(:list)
    end

    context 'リストの更新ができる場合' do
      it 'リストが更新できる' do
        @list[:name] = "updated!!"
        post sign_in_path, params: {user: {email: @list.user.email, password: @list.user.password}},xhr: true
        expect(response).to have_http_status(200)
        patch "/lists/#{@list.id}", params: {list: {name: @list.name, user_id: @list.user.id, board_id: @list.board.id}}, xhr: true
        res = JSON.parse(response.body)
        res.each do |data|
          expect(data["name"]).to include @list.name
        end
      end
    end

    context 'リストの更新ができない場合' do
      it 'リストの名前の入力がない場合' do
        @list[:name] = ""
        post sign_in_path, params: {user: {email: @list.user.email, password: @list.user.password}},xhr: true
        expect(response).to have_http_status(200)
        patch "/lists/#{@list.id}", params: {list: {name: @list.name, user_id: @list.user.id, board_id: @list.board.id}}, xhr: true
        res = JSON.parse(response.body)
        expect(res["errors"]).to include("リストの名前を入力してください。")
      end

      it 'ユーザーidが存在しない場合' do
        @list.user.id = nil
        patch "/lists/#{@list.id}", params: {list: {name: @list.name, user_id: @list.user.id, board_id: @list.board.id}}, xhr: true
        res = JSON.parse(response.body)
        expect(res["errors"]).to include("ログインしてください。")
      end

      it 'ユーザーidが存在しない場合' do
        @list.board.id = nil
        post sign_in_path, params: {user: {email: @list.user.email, password: @list.user.password}},xhr: true
        expect(response).to have_http_status(200)
        patch "/lists/#{@list.id}", params: {list: {name: @list.name, user_id: @list.user.id, board_id: @list.board.id}}, xhr: true
        res = JSON.parse(response.body)
        expect(res["errors"]).to include("ボードを作成してください。")
      end
    end
  end

  describe 'lists/#destroy' do
    before do
      @list = FactoryBot.create(:list)
    end

    context 'リストの削除ができる場合' do
      it 'リストの削除ができる' do
        post sign_in_path, params: {user: {email: @list.user.email, password: @list.user.password}},xhr: true
        expect(response).to have_http_status(200)
        delete "/lists/#{@list.id}", xhr: true
        res = JSON.parse(response.body)
        expect(res).to eq []
      end
    end
  end

end
