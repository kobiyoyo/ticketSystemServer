# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Department.create(title:"finance")

User.create(first_name: "daniel", last_name: "adama", email: "sinnry@gmail.com", role: "admin", password: "Adamachubiy", phone_no: "08034194700", department_id: 1, active: true) 