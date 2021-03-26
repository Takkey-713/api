require 'rails_helper'

RSpec.describe "Tasks", type: :request do
  describe 'tasks/#create' do
    before do
      @user = FactoryBot.create(:user)
      @board = FactoryBot.create(:board)
      @list = FactoryBot.create(:list)
      @task = FactoryBot.attributes_for(:task)
      @task[:user_id], @task[:board_id], @task[:list_id] = @user.id ,@board.id, @list.id

    end
    context 'タスクの新規作成に成功する' do
      it 'タスクの作成ができる' do
        post sign_in_path, params: {user: {email: @user.email, password: @user.password}},xhr: true
        expect(response).to have_http_status(200)
        post tasks_path, params: {task: @task}, xhr: true
        res = JSON.parse(response.body)
        res.each do |data|
          expect(data["name"]).to eq @task[:name]
        end
      end
    end

    context 'タスクの新規作成ができない場合' do
      it 'ユーザーidが存在しない場合' do 
        @task[:user_id] = nil
        post tasks_path, params: {task: @task}, xhr: true
        res = JSON.parse(response.body)
        expect(res["errors"]).to include("ログインしてください。")
      end
    end

    it 'ボードidが存在しない場合' do
      post sign_in_path, params: {user: {email: @user.email, password: @user.password}},xhr: true
      expect(response).to have_http_status(200)
      @task[:board_id] = nil
      post tasks_path, params: {task: @task}, xhr:true
      res = JSON.parse(response.body)
      expect(res["errors"]).to include("ボードを作成してください。")
    end

    it 'リストidが存在しない場合' do
      post sign_in_path, params: {user: {email: @user.email, password: @user.password}},xhr: true
      expect(response).to have_http_status(200)
      @task[:list_id] = nil
      post tasks_path, params: {task: @task}, xhr:true
      res = JSON.parse(response.body)
      expect(res["errors"]).to include("リストを作成してください。")
    end
  end

  describe 'tasks/#update' do
    context 'タスクの更新ができる場合' do
      before do
        @task = FactoryBot.create(:task)
      end

      it 'タスクが更新できる' do
        post sign_in_path, params: {user: {email: @task.user.email, password: @task.user.password}},xhr: true
        expect(response).to have_http_status(200)
        @task.name = "updated!!"
        patch "/tasks/#{@task.id}", params: {task: {id: @task.id, name: @task.name, explanation: @task.explanation, deadline_date: @task.deadline_date, board_id: @task.board.id, list_id: @task.list.id}}, xhr: true
        res = JSON.parse(response.body)
        res.each do |data|
          expect(data["name"]).to eq @task.name
        end
      end
    end

    context 'タスクの更新ができない場合' do
      before do
        @task = FactoryBot.create(:task)
      end

      it 'ユーザーidが存在しない' do
        @task.user.id = nil
        patch "/tasks/#{@task.id}", params: {task: {id: @task.id, name: @task.name, explanation: @task.explanation, deadline_date: @task.deadline_date, user_id: @task.user.id, board_id: @task.board.id, list_id: @task.list.id}}, xhr: true
        res = JSON.parse(response.body)
          expect(res["errors"]).to include("ログインしてください。")
      end

      it 'ボードidが存在しない' do
        post sign_in_path, params: {user: {email: @task.user.email, password: @task.user.password}},xhr: true
        expect(response).to have_http_status(200)
        @task.board.id = nil
        patch "/tasks/#{@task.id}", params: {task: {id: @task.id, name: @task.name, explanation: @task.explanation, deadline_date: @task.deadline_date, user_id: @task.user.id, board_id: @task.board.id, list_id: @task.list.id}}, xhr: true
        res = JSON.parse(response.body)
        expect(res["errors"]).to include("ボードを作成してください。")
      end

      it 'リストidが存在しない場合' do
        post sign_in_path, params: {user: {email: @task.user.email, password: @task.user.password}},xhr: true
        expect(response).to have_http_status(200)
        @task.list.id = nil
        patch "/tasks/#{@task.id}", params: {task: {id: @task.id, name: @task.name, explanation: @task.explanation, deadline_date: @task.deadline_date, user_id: @task.user.id, board_id: @task.board.id, list_id: @task.list.id}}, xhr: true
        res = JSON.parse(response.body)
        expect(res["errors"]).to include("リストを作成してください。")
      end
      it 'タスクの名前の入力がない場合' do
        post sign_in_path, params: {user: {email: @task.user.email, password: @task.user.password}},xhr: true
        expect(response).to have_http_status(200)
        @task.name = ""
        patch "/tasks/#{@task.id}", params: {task: {id: @task.id, name: @task.name, explanation: @task.explanation, deadline_date: @task.deadline_date, user_id: @task.user.id, board_id: @task.board.id, list_id: @task.list.id}}, xhr: true
        res = JSON.parse(response.body)
        expect(res["errors"]).to include("タスクの名前を入力してください。")
      end
    end
  end

  describe 'tasks/#delete' do
    context 'タスクが削除できる' do
      before do
        @task = FactoryBot.create(:task)
      end

      it 'タスクが削除できる' do
        post sign_in_path, params: {user: {email: @task.user.email, password: @task.user.password}},xhr: true
        expect(response).to have_http_status(200)
        delete "/tasks/#{@task.id}", params: {task: @task}, xhr: true
        res = JSON.parse(response.body)
        expect(res).to eq []
      end
    end
  end

  describe '' do
    context '' do
      it '' do
      end
    end
  end

  describe '' do
    context '' do
      it '' do
      end
    end
  end
end