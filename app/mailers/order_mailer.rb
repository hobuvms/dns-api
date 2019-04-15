class OrderMailer < ApplicationMailer

  def vendor_sign_up(name:, email:, phone:, location:, company:, referral:)
    @name = name
    @email = email
    @phone = phone
    @location = location
    @company = company
    @referral = referral
    mail(subject: 'New Vendor Sign-up DealsAndServices.com', to: 'supratip@dealsandservices.com')
  end

  def customer_send_email(options={})
    @name = options[:name]
    @phone = options[:phone]
    @address = options[:address]
    @customer_email = options[:customer_email]
    @notes = options[:notes]
    mail(to: options[:customer_email], subject: 'Thanks for visiting DealsAndServices.com', bcc: 'supratip@dealsandservices.com')
  end

  def vendor_send_email(options={})
    @name = options[:name]
    @phone = options[:phone]
    @address = options[:address]
    @customer_email = options[:customer_email]
    @vendor_email = options[:vendor_email]
    @notes = options[:notes]
    mail(to: options[:vendor_email], subject: 'Customer Request From Deals And Services', bcc: 'supratip@dealsandservices.com',
         from: 'DealsAndServices<sales@dealsandservices.com>')
  end

  def welcome_vendor(user_id:)
    @user = User.find_by(id: user_id)
    raise 'User not found' if @user.nil?
    mail(subject: 'Congratulations for joining DealsAndServices', to: @user.email)
  end

  def reset_password(email:, token:)
    @token = token
    mail(to: email, subject: 'DealsAndServices.com: Reset Password')
  end

  def contact_us(message)
    @message = message
    mail(to: 'supratip@dealsandservices.com', subject: 'Contact Us: Request')
  end
end
