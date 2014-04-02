class Notify < ActionMailer::Base
  default from: "hello@simvla.com"
  
  # Notify.test("hello@simvla.com").deliver
  def test(to)
    mail(:to => to, :subject => "Welcome to Simvla")
  end
  
  def send_application(message)
    @message = message
    mail(:to => "members@simvla.com", :subject => "Simvla - New Application")
  end
end
