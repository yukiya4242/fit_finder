# frozen_string_literal: true
ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do
    columns do
      column do
        panel "New Users" do
          ul do
            User.where("created_at >= ?", Time.now.beginning_of_day).map do |user|
              li link_to(user.email, admin_user_path(user))
            end
          end
        end
         panel "Recentry Active Users" do
           ul do
             User.where("updated_at >= ?", 1.day.ago).map do |user|
               li link_to(user.email, admin_user_path(user))
             end
           end
         end
      end
    end

    div class: "blank_slate_container", id: "dashboard_default_message" do
      span class: "blank_slate" do
        span I18n.t("active_admin.dashboard_welcome.welcome")
        small I18n.t("active_admin.dashboard_welcome.call_to_action")
      end
    end
  end # content end
end # ActiveAdmin.register_page "Dashboard" end
