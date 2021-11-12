class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :item_condition
  belongs_to :shipping_fee
  belongs_to :shipping_prefecture
  belongs_to :shipping_schedule

  belongs_to :user
  has_one_attached :image

  with_options presence: true do
    validates :image
    validates :item_name
    validates :item_info
    validates :price
  end
  validates :price, numericality: { only_integer: true, message: "は半角数値で入力"}
  validates :price, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999, message: "は¥300~¥9,999,999の間で入力" }
  validates :category_id, :item_condition_id, :shipping_fee_id, :shipping_prefecture_id, :shipping_schedule_id, numericality: { other_than: 1 , message: "can't be blank"}
  
end