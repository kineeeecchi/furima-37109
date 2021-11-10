require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できるとき' do
      it 'nickname ~ birthdayまで全てが存在すれば登録できる' do
        expect(@user).to be_valid
      end
    end
    context '新規登録できないとき' do
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'last_nameが空では登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank")
      end
      it 'first_nameが空では登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end
      it 'last_name_kanaが空では登録できない' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana can't be blank")
      end
      it 'first_name_kanaが空では登録できない' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank")
      end
      it 'birthdayが空では登録できない' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end
      it '重複したemailが存在する場合登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end
      it 'emailに@を含まない場合登録できない' do
        @user.email = 'abc123456.com'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end
      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'passwordが5文字以下では登録できない' do
        @user.password = 'abc12'
        @user.password_confirmation = 'abc12'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end
      it 'passwordが半角英数字でない場合登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password には半角で英字と数字を含めてください')
      end
      it 'passwordが半角英数字でない場合登録できない' do
        @user.password = 'aaaaaa'
        @user.password_confirmation = 'aaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password には半角で英字と数字を含めてください')
      end
      it 'passwordが半角英数字でない場合登録できない' do
        @user.password = '１２３abc'
        @user.password_confirmation = '１２３abc'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password には半角で英字と数字を含めてください')
      end
      it 'last_nameが、全角（漢字・ひらがな・カタカナ）でない場合登録できない' do
        @user.last_name = 'Yamada 3'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name は全角文字を使用してください')
      end
      it 'first_nameが、全角（漢字・ひらがな・カタカナ）でない場合登録できない' do
        @user.first_name = 'Taro 3'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name は全角文字を使用してください')
      end
      it 'last_name_kanaが、全角（カタカナ）でない場合登録できない' do
        @user.last_name_kana = 'Yamada 3'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kana は全角カタカナを使用してください')
      end
      it 'last_name_kanaが、全角（カタカナ）でない場合登録できない' do
        @user.last_name_kana = '一の瀬'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kana は全角カタカナを使用してください')
      end
      it 'first_name_kanaが、全角（カタカナ）でない場合登録できない' do
        @user.first_name_kana = 'Taro 3'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana は全角カタカナを使用してください')
      end
      it 'first_name_kanaが、全角（カタカナ）でない場合登録できない' do
        @user.first_name_kana = 'ひろ子'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana は全角カタカナを使用してください')
      end
    end
  end
end
