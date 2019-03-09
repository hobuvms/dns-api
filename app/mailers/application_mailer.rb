class ApplicationMailer < ActionMailer::Base
  default from: 'DealsAndServices<no-reply@dealsandservices.com>'
  layout 'mailer'
end
