require 'rails_helper'

RSpec.describe Board, type: :model do
  before do
    @board = FactoryBot.build(:board)
  end

  context 'リストの作成に成功する' do
    it '全てのデータが入力される' do
      @board.valid? 
      expect(@board.valid?).to eq true
    end
  end

    context '登録ができない場合' do
      it "リストの名前の入力がない場合" do
        @board.name = nil
        @board.valid?
        expect(@board.errors.full_messages).to include("Name can't be blank")
      end

      it "user_idを持たない場合" do
        @board.user= nil
        @board.valid?
        expect(@board.errors.full_messages).to include("User must exist")
      end
    end
end
