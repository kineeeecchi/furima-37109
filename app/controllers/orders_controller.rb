class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :move_to_root_path, only: [:index]

  def index
    @item = Item.find(params[:item_id])
    @order_destination_detail = OrderDestinationDetail.new
  end

  def create
    @item = Item.find(params[:item_id])
    @order_destination_detail = OrderDestinationDetail.new(order_params)
    if @order_destination_detail.valid?
      pay_item
      @order_destination_detail.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def order_params
    params.require(:order_destination_detail).permit(:postal_code, :shipping_prefecture_id, :city, :address_line1, :address_line2, :phone_number).merge(
      user_id: current_user.id, item_id: params[:item_id], token: params[:token]
    )
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: order_params[:token],
      currency: 'jpy'
    )
  end

  def move_to_root_path
    @item = Item.find(params[:item_id])
    redirect_to root_path if (current_user.id != @item.user_id && @item.order.present?) || (current_user.id == @item.user_id)
  end
end
