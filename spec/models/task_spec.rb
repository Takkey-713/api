require 'rails_helper'

RSpec.describe Task, type: :model do
  before do
    @task = FactoryBot.build(:task)
  end

  context 'タスクの作成に成功する' do
    it '全てのデータが入力される' do
      @task.valid? 
      expect(@task.valid?).to eq true
    end
  end    

  context '登録ができない場合' do
    it "タスクの名前の入力がない場合" do
      @task.name = nil
      @task.valid?
      expect(@task.errors.full_messages).to include("Name can't be blank")
    end

    it "user_idを持たない場合" do
      @task.user= nil
      @task.valid?
      expect(@task.errors.full_messages).to include("User must exist")
    end

    it "board_id(リストのid)を持たない場合" do 
      @task.board = nil
      @task.valid?
      expect(@task.errors.full_messages).to include("Board must exist")
    end
    
    
  end
end
