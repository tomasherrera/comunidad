# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!
config.action_mailer.delivery_method = :smtp

ActionMailer::Base.smtp_settings = {
  :address  => "smtp.sendgrid.net",
  :port  => 25,
  :user_name  => "app36474527@heroku.com",
  :password  => "mypass",
  :authentication  => :login
}
