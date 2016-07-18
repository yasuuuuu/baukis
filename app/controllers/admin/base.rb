class Admin::Base < ApplicationController
  before_action :authorize, :check_account, :check_timeout

  TIMEOUT = 60.minutes

  private

  def authorize
    unless current_administrator
      flash.alert = '管理者としてログインしてください。'
      redirect_to :admin_login
    end
  end

  def check_account
    if current_administrator && !current_administrator.active?
      session.delete(:administrator_id)
      flash.alert = 'アカウントが無効になりました。'
      redirect_to :admin_root
    end
  end

  def check_timeout
    if current_administrator
      if session[:last_access_time] >= TIMEOUT.ago
        session[:last_access_time] = Time.current
      else
        session.delete(:administrator_id)
        flash.alert = 'セッションがタイムアウトしました。'
        redirect_to :admin_login
      end
    end
  end

  def current_administrator
    if session[:administrator_id]
      @current_administrator ||=
        Administrator.find_by(id: session[:administrator_id])
    end
  end

  helper_method :current_administrator
end
