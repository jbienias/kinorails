# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# encoding allowing polish letters
# ruby encoding: utf-8

user_list = [
  # role: admin | username: admin | password: admin1234
  ["admin@admin.com", "admin1234", "2018-12-02 15:00:00.132610", "2018-12-02 15:00:00.132610", "admin", 1],
  # role: user | username: test_user_one | password: test1234
  ["test_one@test.pl", "test1234", "2018-12-02 15:00:00.132611", "2018-12-02 15:00:00.132611", "test_user_one", 0],
  # role: user | username: test_user_two | password: test4321
  ["test_two@test.pl", "test4321", "2018-12-02 15:00:00.132612", "2018-12-02 15:00:00.132612", "test_user_two", 0]
]

user_list.each do |email, password, created_at, updated_at, username, role|
  User.create!(email: email, password: password, created_at: created_at, updated_at: updated_at, username: username, role: role)
end
