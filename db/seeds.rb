# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'
Department.create(title:"finance")

User.create(first_name: "chubi",
			 last_name: "adama", 
			 email: "adama@gmail.com",
			  role: "admin", 
			  password: "Adamachubiy", 
			  phone_no: "08034194700",
			  department_id: 1, active: true) 
2.times{
User.create(first_name: Faker::Name.first_name ,
			 last_name: Faker::Name.last_name  , 
			 email: Faker::Internet.email,
			  role: "customer", 
			  password: "Adamachubiy", 
			  phone_no: Faker::PhoneNumber.cell_phone,
			  department_id: 1, active: true) 
}
2.times{
User.create(first_name: Faker::Name.first_name ,
			 last_name: Faker::Name.last_name  , 
			 email: Faker::Internet.email,
			  role: "agent", 
			  password: "Adamachubiy", 
			  phone_no: Faker::PhoneNumber.cell_phone,
			  department_id: 1, active: true) 
}