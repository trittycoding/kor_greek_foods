class OffersMailer < ApplicationMailer
  default from: 'ttaylor78@academic.rrc.ca'

  def offer_email
    mail(to: @user.email, subject: '**Test Email -- KOR Offers**')
  end
end
