class Admin::TopController < Admin::Base
  def index
    render action: 'index'
    # raise IpAddressRejected
  end
end
