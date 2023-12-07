%w[joe@example.com jane@example.com zoe@example.com].each do |email|
  Rails.configuration.command_bus.call(IdentityAndAccess::RegisterUser.new(email, "password"))
end
