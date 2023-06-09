class NotificationDecorator < Draper::Decorator
  delegate_all

  def how_long_ago
    if (Time.now - object.created_at) <= 60 * 60
      ((Time.now - object.created_at) / 60).to_i.to_s + "分前"
    elsif (Time.now - object.created_at) <= 60 * 60 * 24
      ((Time.now - object.created_at) / 3600).to_i.to_s + "時間前"
    elsif (Date.today - object.created_at.to_date) <= 30
      (Date.today - object.created_at.to_date).to_i.to_s + "日前"
    else
      object.created_at
    end
  end
end