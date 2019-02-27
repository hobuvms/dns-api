class OrderMailer < ApplicationMailer
  def customer_send_email(options={})
    @name = options[:name]
    @phone = options[:phone]
    @address = options[:address]
    @customer_email = options[:customer_email]
    @notes = options[:notes]
    mail(to: options[:customer_email], subject: "Thanks for visiting DealsAndServices.com", cc: "supratip@dealsandservices.com")
  end
end
