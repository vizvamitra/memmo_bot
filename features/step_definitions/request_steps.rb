When(/^"([^"]*)" sends "([^"]*)" command$/) do |user_name, command|
  user = @users[user_name] || raise("No such user: #{user_name}")
  json = TelegramRequestBuilder.new(user: user, message: command).build.to_json
  @response = post(webhook_path('abc'), json)
end
