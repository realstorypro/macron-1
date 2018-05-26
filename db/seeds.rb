if User.find_by_email("support@idealogic.io").nil?
  puts 'creating a support user with admin privilidges'

  password = "id3aman@#{rand(1..5)}"
  user = User.new
  user.email = "support@idealogic.io"
  user.username = "support"
  user.slug = "support"
  user.password = password
  user.password_confirmation = password
  user.add_role "admin"
  user.save!
end
