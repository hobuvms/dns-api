class OrderMailer < ApplicationMailer
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
         from: 'sales@dealsandservices.com')
  end
end
