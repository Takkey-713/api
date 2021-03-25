require 'rails_helper'

RSpec.describe List, type: :model do
  before do
    @list = FactoryBot.build(:list)
  end

  context 'リストの作成に成功する' do
    it '全てのデータが入力される' do
      @list.valid?
      expect(@list.valid?).to eq true
    end
  end

  context '登録ができない場合' do
    it "リストの名前の入力がない場合" do
      @list.name = ""
      @list.valid?
      expect(@list.errors.full_messages).to include("Name can't be blank")
    end

    it "use_idが存在しない場合" do
      @list.user = nil 
      @list.valid?
      expect(@list.errors.full_messages).to include("User must exist") 
    end

    it "board_idが存在しない場合" do 
      @list.board = nil
      @list.valid?
      expect(@list.errors.full_messages).to include("Board must exist")
    end
  end
end
