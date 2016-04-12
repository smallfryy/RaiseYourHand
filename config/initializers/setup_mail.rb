ActionMailer::Base.smtp_settings = {
  :address              => "stmp.gmail.com",
  :port                 => 25,
  :domain               => "http:localhost:3000",
  :user_name            => "mmikhalevsky@gmail.com",
  :password             => "michelle",
  :authentication       => "plain",
  :enable_starttls_auto => true
}