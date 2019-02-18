# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  SENDER_MAIL = 'vicky@dealsandservices.com'
  default from: ''
  layout 'mailer'

  def send_mail(to, message)
    smtp_username = 'AKIAJX4EWPDZQYCSYOAQ'
    smtp_password = 'ArQo6s+HfJdAtRR/t9cp4/ldhHEHFRxWe/ne/GZH0aka'
    server = 'email-smtp.us-east-1.amazonaws.com'
    smtp = Net::SMTP.new(server, 587)
    smtp.enable_starttls
    smtp.start(server, smtp_username, smtp_password, :login)
    smtp.send_message(message, SENDER_MAIL, to)
  end

  def build_message(to, subject, body)
    [
      'Content-Type: text/html; charset=UTF-8',
      'Content-Transfer-Encoding: 7bit',
      "From: DealsAndServices <#{SENDER_MAIL}>",
      "To: #{to}",
      "Subject: #{subject}",
      '',
      '',
      body
    ].join("\n")
  end

  def build_body
    caller(1..1).first[/`([^']*)'/, 1]
    html_content = File.read("#{Rails.root}/app/views/#{self.class.mailer_name}/#{Regexp.last_match(1)}.erb")
    ERB.new(html_content).result(binding)
  end
end
