class NotificationsController < ApplicationController
  load_and_authorize_resource only: :update

  def index
    @notifications = current_user.notifications.order created_at: :desc
  end

  def update
    @notification.update_attributes seen: true
    binding.pry
    case @notification.action
    when "follower"
      redirect_to @notification.user
    when "commented"
      redirect_to @notification.notifiable.review
    when "replied"
      redirect_to @notification.notifiable.review
    when "liked"
      if @notification.notifiable_type == "Comment"
        if redirect_to @notification.notifiable.root?
          redirect_to @notification.notifiable.review
        else
          redirect_to @notification.notifiable.parent.review
        end
      else
        redirect_to @notification.notifiable
      end
    when "reported"
      redirect_to @notification.notifiable
    when "banned"
      root_path
    end
  end
end
