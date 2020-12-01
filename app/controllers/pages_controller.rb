class PagesController < ApplicationController
  def permalink
    @page = Page.find_by(permalink: params[:permalink])
  end

  def send_mail
    @user = current_user
    OffersMailer.with(user: @user).offer_email.deliver_now
    redirect_to root_url
  end
end
