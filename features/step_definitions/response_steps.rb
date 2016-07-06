Then(/^bot should respond with the following json:$/) do |string|
  expect(JSON.parse(@response.body)).to eq JSON.parse(string)
end

Then(/^bot should respond with the following text:$/) do |string|
  response_text = JSON.parse(@response.body)["text"]
  expect(response_text).to eq string
end

Then(/^parse mode should be "([^"]*)"$/) do |parse_mode|
  actual_parse_mode = JSON.parse(@response.body)["parse_mode"]
  expect(actual_parse_mode).to eq parse_mode
end