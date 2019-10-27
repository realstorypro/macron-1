if User.find_by_email("support@goodlogik.com").nil?
  puts "creating a support user with admin privilidges"
  password = "id3aman@#{rand(1..5)}"
  user = User.new
  user.email = "support@goodlogik.com"
  user.username = "logiksupport"
  user.slug = "logiksupport"
  user.password = password
  user.password_confirmation = password
  user.add_role "admin"
  user.save!
end
