# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
user = User.create!(name: "Antonio",
                    family_name: "Aguilar Ayanz",
                    birthdate: "27/10/1988",
                    email: "aguipluto@gmail.com",
                    password: "27101988",
                    password_confirmation: "27101988",
                    nif: '52895101T',
                    admin: true,
                    confirmed: true)