FactoryBot.define do
  factory :order_destination_detail do
    token                  { 'tok_abcdefghijk00000000000000000' }
    postal_code            { '123-4567' }
    shipping_prefecture_id { 2 }
    city                   { '東京' }
    address_line1          { '1-111-1' }
    address_line2          { 'AK hills' }
    phone_number           { '08012345678' }

    association :user
    association :item
  end
end
