require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    user = FactoryBot.create(:user)
    @item = FactoryBot.build(:item, user_id: user.id)
  end

  describe '商品出品登録' do
    context '出品登録できるとき' do
      it 'image~priceまで全てが存在すれば登録できる' do
        expect(@item).to be_valid
      end
    end
    context '出品登録できないとき' do
      it 'imageが空では登録できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
      it 'item_nameが空では登録できない' do
        @item.item_name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Item name can't be blank")
      end
      it 'item_infoが空では登録できない' do
        @item.item_info = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Item info can't be blank")
      end
      it 'category_idが未選択だと登録できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank")
      end
      it 'item_condition_idが未選択だと登録できない' do
        @item.item_condition_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Item condition can't be blank")
      end
      it 'shipping_fee_idが未選択だと登録できない' do
        @item.shipping_fee_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping fee can't be blank")
      end
      it 'shipping_prefecture_idが未選択だと登録できない' do
        @item.shipping_prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping prefecture can't be blank")
      end
      it 'shipping_schedule_idが未選択だと登録できない' do
        @item.shipping_schedule_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping schedule can't be blank")
      end
      it 'priceが空では登録できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end
      it 'priceは半角数字でないと登録できない' do
        @item.price = '１０００'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price は半角数値で入力')
      end
      it 'priceは¥300以上でないと登録できない' do
        @item.price = 100
        @item.valid?
        expect(@item.errors.full_messages).to include('Price は¥300~¥9,999,999の間で入力')
      end
      it 'priceは¥300~¥9,999,999の間でないと登録できない' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include('Price は¥300~¥9,999,999の間で入力')
      end
      it 'userが紐づいていなければ出品できない' do
        @item.user_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("User must exist")
      end
    end
  end
end
