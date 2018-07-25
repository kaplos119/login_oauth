# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

states=['andaman nicobar',
'andhra pradesh',
'arunachal pradesh',
'assam',
'bihar',
'chandigarh',
'chhattisgarh',
'dadra nagar haveli',
'daman diu',
'delhi',
'goa',
'gujarat',
'haryana',
'himachal pradesh',
'jammu kashmir',
'jharkhand',
'karnataka',
'kerala',
'lakshadweep',
'madhya pradesh',
'maharashtra',
'manipur',
'meghalaya',
'mizoram',
'nagaland',
'odisha',
'puducherry',
'punjab',
'rajasthan',
'sikkim',
'tamil nadu',
'telangana',
'tripura',
'uttar pradesh',
'uttarakhand',
'west bengal']

states.each{|state|
	State.create! :name => state
}

cities = ['ajmer',
'alwar',
'banswara',
'baran',
'barmer',
'bharatpur',
'bhilwara',
'bikaner',
'bundi',
'chittorgarh',
'churu',
'dausa',
'dholpur',
'dungarpur',
'ganganagar',
'hanumangarh',
'jaipur',
'jaisalmer',
'jalore',
'jhalawar',
'jhunjhunu',
'jodhpur',
'karauli',
'kota',
'nagaur',
'pali',
'pratapgarh',
'rajsamand',
'sawai madhopur',
'sikar',
'sirohi',
'tonk',
'udaipur']

cities.each{|ct|
	City.create! :state_id => State.find_by_name('rajasthan').id, :name => ct
}

State.all.each{|st|
cities = st.cities
cities.each{|city|
ii = 1
while ( ii < 6) do
name = 'package_'+ii.to_s+'_'+city.name
Package.create! :package_name => name, :city_id => city.id
ii = ii+1
end
}
}