class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :item_condition
  belongs_to :shipping_fee
  belongs_to :shipping_prefecture
  belongs_to :shipping_schedule

  belongs_to :user
  has_one_attached :image

  
end
