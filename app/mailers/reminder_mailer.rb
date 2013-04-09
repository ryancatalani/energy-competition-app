class ReminderMailer < ActionMailer::Base
  default from: "Energy Competition <catalani.ryan@gmail.com>"

  def daily_reminder_email(user)
  	@name = user.name
  	@url = "http://ecunplugged.heroku.com/entries/new?id=#{user.id}"
  	mail(:to => user.email, :subject => "Energy competition: daily reminder")
  end

end
