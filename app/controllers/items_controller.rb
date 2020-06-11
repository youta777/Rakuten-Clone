class ItemsController < ApplicationController
  before_action :require_user_logged_in

  def new
    @items = []

    @keyword = params[:keyword]
    if @keyword.present?
      results = RakutenWebService::Ichiba::Item.search({
        keyword: @keyword,
        imageFlag: 1,
        hits: 20
      })

      results.each do |result|
        # 扱いやすいようにItemとしてインスタンスを作成する(ここでは保存はしない)
        item = Item.find_or_initialize_by(read)
        @items << item
      end
    end
  end

end
