namespace :db do
	desc "Send daily reminders"
	task :daily_reminders => :environment do

		User.all.each do |user|
			ReminderMailer.daily_reminder_email(user).deliver rescue nil
		end

	end
end