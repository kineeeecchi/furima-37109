# usersテーブル

| Column              | Type       | Options                   |
|---------------------|------------|---------------------------|
| nickname            | string     | null: false               |
| email               | string     | null: false, unique: true |
| encrypted_password  | string     | null: false               |
| last_name           | string     | null: false               |
| first_name          | string     | null: false               |
| last_name_kana      | string     | null: false               |
| first_name_kana     | string     | null: false               |
| birthday            | date       | null: false               |

## Association
-has_many :items
-has_many :orders

# itemsテーブル

| Column                 | Type       | Options                        |
|------------------------|------------|--------------------------------|
| item_name              | string     | null: false                    |
| item_info              | text       | null: false                    |
| category_id            | integer    | null: false                    |
| item_condition_id      | integer    | null: false                    |
| shipping_fee_id        | integer    | null: false                    |
| shipping_prefecture_id | integer    | null: false                    |
| shipping_schedule_id   | integer    | null: false                    |
| price                  | integer    | null: false                    |
| user                   | references | null: false, foreign_key: true |

## Association
-belongs_to :user
-has_one :order

# ordersテーブル

| Column              | Type       | Options                        |
|---------------------|------------|--------------------------------|
| user                | references | null: false, foreign_key: true |
| item                | references | null: false, foreign_key: true |

## Association
-belongs_to :user
-belongs_to :item
-has_one :destination_detail

# destination_detailsテーブル

| Column                       | Type       | Options                        |
|------------------------------|------------|--------------------------------|
| postal_code                  | string     | null: false                    |
| shipping_prefecture_id       | integer    | null: false                    |
| city                         | string     | null: false                    |
| address_line1                | string     | null: false                    |
| address_line2                | string     |                                |
| phone_number                 | string     | null: false                    |
| order                        | references | null: false, foreign_key: true |

## Association
-belongs_to :order
