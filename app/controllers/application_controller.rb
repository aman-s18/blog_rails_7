class ApplicationController < ActionController::Base
  before_action :set_notifications, if: :current_user
  before_action :set_query!
  before_action :set_categories
  before_action :set_locale

  def set_query!
    @query = Post.ransack(params[:q])
    @portal_session = current_user.payment_processor&.billing_portal if current_user
  end

  def set_categories
    @nav_categories = Category.display_in_nav.order(name: :asc)
  end

  def is_admin?
    redirect_to root_path, alert: "You are not authorized to do that!" unless current_user&.admin?
  end
  
  private
    def set_notifications
      notifications = Notification.includes(:recipient).where(recipient: current_user).newest_first.limit(9)
      @unread = notifications.unread
      @read = notifications.read
    end

    def set_locale
      I18n.locale = params[:locale] || I18n.default_locale
    end
end
