# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# The admin user, to be pre-configured
adminUser = User.create(email: ENV["MAKESOMENOTES_ADMIN_EMAIL"].dup, 
                        password: ENV["MAKESOMENOTES_ADMIN_PASSWORD"].dup, 
                        is_admin: true)
