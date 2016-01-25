# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

users = FactoryGirl.build_list(:user, 1000)
User.import users, validate: false
User.find_each do |user|
  Post.import FactoryGirl.build_list(:post, 1000, user: user), validate: false
end
