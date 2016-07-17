class Staff::Base < ApplicationController
  before_action :authorize, :check_account, :check_timeout

  TIMEOUT = 60.minutes

  private

  def authorize
    unless current_staff_member
      flash.alert = '職員としてログインしてください。'
      redirect_to :staff_login
    end
  end

  def check_account
    if current_staff_member && !current_staff_member.active?
      session.delete(:staff_member_id)
      flash.alert = 'アカウントが無効になりました。'
      redirect_to :staff_root
    end
  end

  def check_timeout
    if current_staff_member
      if session[:last_access_time] >= TIMEOUT.ago
        session[:last_access_time] = Time.current
      else
        session.delete(:staff_member_id)
        flash.alert = 'セッションがタイムアウトしました。'
        redirect_to :staff_login
      end
    end
  end

  def current_staff_member
    if session[:staff_member_id]
      @current_staff_member ||=
        StaffMember.find_by(id: session[:staff_member_id])
    end
  end

  helper_method :current_staff_member
end
