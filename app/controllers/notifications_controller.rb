class NotificationsController < ApplicationController
  before_action :authenticate_user!, only:[:index, :update]

  def index
    #current_userが受け取った全ての通知を取得し、その結果をページングする(gem kaminari)
    @notifications = current_user.passive_notifications.includes(:visitor, :comment, :post).page(params[:page]).per(20)
    @notification = Notification.find_by(id: params[:id]) #特定の通知を取得
    @notification = @notification.decorate if @notification.present? #取得した通知にデコレートパターンを適用。
    @notifications.update(checked: true) #全ての通知を既読済みにする
  end


  def update
    notification = Notification.find(params[:id]) #指定されたIDの通知を見つける
    if notification.update(checked: true) #その通知のステータスを既読に更新
      redirect_to notifications_path #通知一覧にリダイレクト
    end
  end

  def destroy
    @notification = Notification.find(params[:id])
    @notification.destroy
  end

end