namespace :db do
	desc "Add some fake data"
	task :fake_data => :environment do

		rooms = [
			[101, 102, 103, 104, 104, 106, 107],
			[501, 502, 503, 504, 505, 506, 507]
		]

		50.times do |i|
			user = User.new
			user.name = Faker::Name.first_name
			user.email = Faker::Internet.email
			user.floor = i.even? ? 1 : 0
			user.phone = Faker::PhoneNumber.cell_phone
			user.room = rooms[user.floor][rand(7)]
			user.save
		end

		maxes = [8, 5, 3]

		14.times do |i|
			User.all.each do |user|
				next if Random.rand(3) == 1 # 1/3 chance of not filling it out

				max = 8
				case i
				when 0..4
					max = 8
				when 5..10
					max = 5
				when 11..14
					max = 3
				end

				entry = Entry.new
				entry.user_id = user.id
				entry.floor = user.floor
				entry.room = user.room

				entry.personal_lightbulbs = Random.rand(max)
				entry.shared_lightbulbs = Random.rand(max)
				entry.plugged_in = Random.rand(max)
				entry.recycled_items = Random.rand(max)
				entry.shower_time = Random.rand(max+10)

				entry.save

				time = Time.now + i.days
				entry.update_attribute(:created_at, time)
				entry.update_attribute(:updated_at, time)

			end
		end


	end
end