class OwnershipsController < ApplicationController
  def create
    @item = Item.find_or_initialize_by(code: params[:item_code])

    unless @item.persisted?
      # @itemが保存されていない場合、先に@itemを保存
      results = RakutenWebService::Ichiba::Item.search(itemCode: @item.code)

      @item = Item.create(read(results.first))
    end

    # Want関係として保存
    if params[:type] == 'Want'
      current_user.want(@item)
      flash[:success] = '商品を欲しいものリストに登録しました'
    end

    redirect_back(fallback_location: root_path)
  end

  def destroy
    @item = Item.find(params[:item_id])

    if params[:type] == 'Want'
      current_user.unwant(@item)
      flash[:success] = '商品を欲しいモノリストから削除しました'
    end

    redirect_back(fallback_location: root_path)
  end
end
