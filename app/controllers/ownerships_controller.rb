class OwnershipsController < ApplicationController
  def create
    @item = Item.find_or_initialize_by(code: params[:item_code])

    unless @item.persisted?
      results = RakutenWebService::Ichiba::Item.search(itemCode: @item.code)

      @item = Item.new(read(results.first))
      @item.save
    end

    if params[:type] == 'Want'
      current_user.want(@item)
      flash[:success] = 'ほしいものリストに追加しました。'
    elsif params[:type] == 'Cart'
      current_user.cart(@item)
      flash[:success] = 'カートに追加しました。'
    end

    redirect_back(fallback_location: root_path)
  end

  def destroy
    @item = Item.find(params[:item_id])

    if params[:type] == 'Want'
      current_user.unwant(@item) 
      flash[:success] = 'ほしいものリストから削除しました。'
    elsif params[:type] == 'Cart'
      current_user.uncart(@item)
      flash[:success] = 'カートから削除しました。'
    end

    redirect_back(fallback_location: root_path)
  end
end
