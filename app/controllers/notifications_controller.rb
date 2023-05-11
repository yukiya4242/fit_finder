class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @notifications = current_user.passive_notifications.includes(:visitor, :comment, :post).page(params[:page]).per(20)
    @notification = Notification.find_by(id: params[:id])
    @notification = @notification.decorate if @notification.present?
  end

  def update
    notification = Notification.find(params[:id])
    if notification.update(checked: true)
      redirect_to notifications_path
    end
  end
end