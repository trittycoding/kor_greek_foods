class OffersMailer < ApplicationMailer
  include Devise::Controllers::Helpers

  default from: 'ttaylor78@academic.rrc.ca'

  def offer_email
    @user = params[:user]
    mail(to: @user.email, subject: '**Test Email -- KOR Offers**')
  end
end
