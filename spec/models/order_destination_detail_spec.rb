require 'rails_helper'

RSpec.describe OrderDestinationDetail, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @order_destination_detail = FactoryBot.build(:order_destination_detail, user_id: user.id, item_id: item.id)
    sleep 0.1
  end

  describe '商品購入' do
    context '商品購入できるとき' do
      it '全ての値が正しく入力されていれば登録できる' do
        expect(@order_destination_detail).to be_valid
      end
      it 'address_line2は空でも登録できる' do
        @order_destination_detail.address_line2 = ''
        expect(@order_destination_detail).to be_valid
      end
    end

    context '商品購入できないとき' do
      it 'クレジット情報が空だと登録できない' do
        @order_destination_detail.token = nil
        @order_destination_detail.valid?
        expect(@order_destination_detail.errors.full_messages).to include("Token can't be blank")
      end
      it 'postal_codeが空だと登録できない' do
        @order_destination_detail.postal_code = ''
        @order_destination_detail.valid?
        expect(@order_destination_detail.errors.full_messages).to include("Postal code can't be blank")
      end
      it 'shipping_prefecture_idが未選択だと登録できない' do
        @order_destination_detail.shipping_prefecture_id = 1
        @order_destination_detail.valid?
        expect(@order_destination_detail.errors.full_messages).to include("Shipping prefecture can't be blank")
      end
      it 'cityが空だと登録できない' do
        @order_destination_detail.city = ''
        @order_destination_detail.valid?
        expect(@order_destination_detail.errors.full_messages).to include("City can't be blank")
      end
      it 'address_line1が空だと登録できない' do
        @order_destination_detail.address_line1 = ''
        @order_destination_detail.valid?
        expect(@order_destination_detail.errors.full_messages).to include("Address line1 can't be blank")
      end
      it 'phone_numberが空だと登録できない' do
        @order_destination_detail.phone_number = ''
        @order_destination_detail.valid?
        expect(@order_destination_detail.errors.full_messages).to include("Phone number can't be blank")
      end
      it 'postal_codeは、「3桁ハイフン4桁」の半角文字列でないと登録できない' do
        @order_destination_detail.postal_code = '1117788'
        @order_destination_detail.valid?
        expect(@order_destination_detail.errors.full_messages).to include('Postal code is invalid. Include hyphen(-)')
      end
      it 'phone_numberは、10桁以上11桁以内の半角数値でないと登録できない' do
        @order_destination_detail.phone_number = '080-1111-2222'
        @order_destination_detail.valid?
        expect(@order_destination_detail.errors.full_messages).to include("Phone number is invalid. Can't include hyphen(-)")
      end
      it 'phone_numberは、10桁以上11桁以内の半角数値でないと登録できない' do
        @order_destination_detail.phone_number = '1236789'
        @order_destination_detail.valid?
        expect(@order_destination_detail.errors.full_messages).to include("Phone number is invalid. Can't include hyphen(-)")
      end
      it 'userが紐付いていないと購入できない' do
        @order_destination_detail.user_id = nil
        @order_destination_detail.valid?
        expect(@order_destination_detail.errors.full_messages).to include("User can't be blank")
      end
    end
  end
end
