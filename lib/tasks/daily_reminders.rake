namespace :db do
	desc "Send daily reminders"
	task :daily_reminders => :environment do

		User.all.each do |user|
			begin
				ReminderMailer.daily_reminder_email(user).deliver

				if user.phone?
					url = "http://ecunplugged.herokuapp.com/entries/new?id=#{user.id}"
					twilio = Twilio::REST::Client.new TWILIO[:account_sid], TWILIO[:auth_token]
					twilio.account.sms.messages.create(
						:from => '+17863294420',
						:to => user.phone,
						:body => "Hi! This is your daily reminder to fill out the energy competition survey: #{url}"
					)
				end
			rescue
				nil
			end
		end

	end
end