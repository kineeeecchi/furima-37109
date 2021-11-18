class OrderDestinationDetail
  include ActiveModel::Model
  attr_accessor :token, :user_id, :item_id, :postal_code, :shipping_prefecture_id, :city, :address_line1, :address_line2,
                :phone_number, :order_id

  with_options presence: true do
    validates :token
    validates :user_id
    validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'is invalid. Include hyphen(-)' }
    validates :city
    validates :address_line1
    validates :phone_number, format: { with: /\A[0-9]{10,11}\z/, message: "is invalid. Can't include hyphen(-)" }
  end
  validates :shipping_prefecture_id, numericality: { other_than: 1, message: "can't be blank" }

  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    DestinationDetail.create(postal_code: postal_code, shipping_prefecture_id: shipping_prefecture_id, city: city,
                             address_line1: address_line1, address_line2: address_line2, phone_number: phone_number, order_id: order.id)
  end
end
