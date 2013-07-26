# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
name = `git config --get user.name`.chomp
email = `git config --get user.email`.chomp

print "Enter a password, #{name}: "; STDOUT.flush()
password = STDIN.readline().chomp

# Create an admin account for the current user.
admin = User.create!({
  :name => name,
  :email => email,
  :password => password,
  :password_confirmation => password,
  :admin => true
})

seed_dir = File.join(__dir__, 'seed')

# Create a news item for every Markdown-formatted file in db/seed/news_items
Dir.glob(File.join(seed_dir, 'news_items', '*.md')) do |file|
  content = File.read(file)
  kind, headline = File.basename(file, '.md').match(/^(\w) - (.*)$/)[1, 2]

  item = NewsItem.create!({
    :user => admin,
    :kind => kind,
    :headline => headline,
    :content => content
  })

  puts "Created '#{item.headline}'."
end

# Create a submission for every Markdown-formatted file in db/seed/submissions/**
Dir.glob(File.join(seed_dir, 'submissions', '**', '*.md')) do |file|
  username = File.basename(File.dirname(file))

  user = User.find_by_name(username) || User.create!({
    :name => username,
    :email => "#{username.underscore}@rateyourwriting.com",
    :password => 'passw0rd',
    :password_confirmation => 'passw0rd'
  })

  content = File.read(file)
  kind, title = File.basename(file, '.md').match(/^(\w) - (.*)$/)[1, 2]

  submission = Submission.create!({
    :user => user,
    :kind => kind,
    :title => title,
    :body => content
  })

  puts "Created '#{submission.title}' by #{user.name}."
end

# For every submission we just created, have most other users cast a random vote
# for it, with votes for any given submission clustering around a certain value
# (to emulate submissions of different quality).
Submission.all.each do |submission|
  # Let's have votes cluster around anywhere from 2 to 9
  q = 2 + rand(8)

  User.all(:conditions => ['id != ?', submission.user_id]).each do |user|
    if rand(100) < 75
      # Randomly assign a rating between q-1 and q+1
      rating = (q - 1) + rand(3)
      user.vote!(submission, rating)
      puts "#{user.name} rated '#{submission.title}' a #{rating}"
    end
  end
end
