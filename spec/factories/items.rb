FactoryBot.define do
  factory :item do
    item_name              { "スマホケース" }
    item_info              { "iPhone用スマホケース" }
    category_id            { 2 }
    item_condition_id      { 2 }
    shipping_fee_id        { 2 }
    shipping_prefecture_id { 2 }
    shipping_schedule_id   { 2 }
    price                  { 3000 }

    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end