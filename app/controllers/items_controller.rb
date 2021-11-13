class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit]
  before_action :move_to_root_path, only: :edit
  before_action :set_item, only: [:edit, :show, :update]

  def index
    @items = Item.all.order('created_at DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item.id)
    else
      render :edit
    end
  end

  def destroy
    item = Item.find(params[:id])
    if user_signed_in? && current_user.id == item.user_id
      item.destroy
      redirect_to root_path
    end
  end

  private

  def item_params
    params.require(:item).permit(:image, :item_name, :item_info, :category_id, :item_condition_id, :shipping_fee_id,
                                 :shipping_prefecture_id, :shipping_schedule_id, :price).merge(user_id: current_user.id)
  end

  def move_to_root_path
    @item = Item.find(params[:id])
    redirect_to root_path unless current_user.id == @item.user_id
  end

  def set_item
    @item = Item.find(params[:id])
  end
end
