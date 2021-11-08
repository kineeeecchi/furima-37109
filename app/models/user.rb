class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  validates :nickname, presence: true

  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i.freeze
  validates :password, format: { with: PASSWORD_REGEX, message: 'には半角で英字と数字を含めてください'}
  
  NAME_REGEX = /\A[ぁ-んァ-ヶ一-龥々ー]+\z/.freeze
  with_options presence: true, format: { with: NAME_REGEX, message: 'は全角文字を使用してください' } do
    validates :last_name
    validates :first_name
  end

  NAME_KANA_REGEX = /\A[ァ-ヶ一]+\z/.freeze
  with_options presence: true, format: { with: NAME_KANA_REGEX, message: 'は全角カタカナを使用してください' } do
    validates :last_name_kana
    validates :first_name_kana
  end

  validates :birthday, presence: true

end
