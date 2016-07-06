Given(/^user "([^"]*)" has following notes:$/) do |user_name, notes_table|
  @users ||= {}
  @users[user_name] ||= User.create(telegram_id: @users.count)
  user = @users[user_name]

  notes_table.hashes.each do |note_data|
    tags = note_data["tags"].gsub('#', '').split(' ').map{|n| Tag.find_or_create_by(name: n)}
    Note.create({
      id: note_data['id'],
      user: user,
      text: note_data['text'],
      name: note_data['comment'],
      created_at: note_data['created_at'],
      tags: tags
    })
  end
end


Given(/^user "([^"]*)" has following note:$/) do |user_name, notes_table|
  @users ||= {}
  @users[user_name] ||= User.create(telegram_id: @users.count)
  user = @users[user_name]

  note_data = notes_table.rows_hash
  tags = note_data["tags"].gsub('#', '').split(' ').map{|n| Tag.find_or_create_by(name: n)}
  Note.create({
    id: note_data['id'],
    user: user,
    text: note_data['text'],
    name: note_data['comment'],
    created_at: note_data['created_at'],
    tags: tags
  })
end