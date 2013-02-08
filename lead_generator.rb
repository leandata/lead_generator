#!/usr/bin/env ruby

require 'rubygems'
require 'faker'

class String
	def titlecase
		non_capitalized = %w{of etc and by the for on is at to but nor or a via}
		gsub(/\b[a-z]+/){ |w| non_capitalized.include?(w) ? w : w.capitalize  }.sub(/^[a-z]/){|l| l.upcase }.sub(/\b[a-z][^\s]*?$/){|l| l.capitalize }
	end
end

street_types = ['St.', 'Street', 'St', 'Way', 'Lane', 'Ln.', 'Ln', 'Road', 'Rd.', 'Rd', 'Terrace', 'Terr.', 'Cir.', 'Circle', 'Highway', 'Hwy', 'Pkwy', 'Pkwy.', 'Avenue', 'Ave', 'Ave.']
state_names = [ "AL", "AK", "AZ", "AR", "CA", "CO", "CT", "DE", "FL", "GA", "HI", "ID", "IL", "IN", "IA", "KS", "KY", "LA", "ME", "MD", "MA", "MI", "MN", "MS", "MO", "MT", "NE", "NV", "NH", "NJ", "NM", "NY", "NC", "ND", "OH", "OK", "OR", "PA", "RI", "SC", "SD", "TN", "TX", "UT", "VT", "VA", "WA", "WV", "WI", "WY"]

first_names = IO.read('first_names.txt').split
first_names.each do |n|
	n.replace n.titlecase
end
last_names = IO.read('last_names.txt').split
street_names = IO.read('street_names.txt').split
domain_names = IO.read('domain_names.txt').split
city_names = IO.read('city_names.txt').split

puts "first name,last name,company,street address,city,state,zip,phone,email"
for i in 1..(ARGV[0].to_i)
	zip = (Random.rand(99999)+1).to_s.rjust(5, '0')
	if(Random.rand(2) == 0)
		zip = zip + '-' + (Random.rand(10000)).to_s
	end
	if(Random.rand(10) == 0)
		if(Random.rand(2) == 0)
			address = "P.O. Box " + (Random.rand(9000)+100).to_s
		else 
			address = "PO Box " + (Random.rand(9000)+100).to_s
		end
	else
		if(Random.rand(2) == 0)
			address = (1 + Random.rand(15000)).to_s + ' ' + street_names.sample + ' ' + street_types.sample 
		else
			address = Faker::Address.street_address
		end
	end
	first = Faker::Name.first_name 
	last = Faker::Name.last_name 
	
	puts "\"#{first}\"," +
		"\"#{last}\"," +
		"\"#{Faker::Company.name.strip}\"," +
		"\"#{address}\"," +
		"\"#{city_names.sample}\"," +
		"\"#{state_names.sample}\"," +
		"\"#{zip}\"," +
		"\"#{Random.rand(800)+200}-#{Random.rand(800)+200}-#{Random.rand(10000).to_s.rjust(4, '0')}\"," +
		"\"#{Faker::Internet.email}\""
end
