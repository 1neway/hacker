5.times do 
  user = User.new
  user.name = Faker::Name.name
  user.email = Faker::Internet.email
  # TODO: change to user.password =, update user model to include bcrypt
  user.password = Faker::Lorem.word
  user.save!
  puts "user created"
  2.times do 
    post = Post.new
    # puts Faker::Company.name
    post.title = Faker::Company.name
    post.url = Faker::Internet.email
    post.user = user
    post.save!
    puts "post created"
  end
end

id_array = []
User.all.each do |user|
  puts "in id_array loop"
  id_array << user.id
end



10.times do 
  comment = Comment.new
  comment.content = Faker::Lorem.sentence
  comment.user = User.find((id_array).sample)
  comment.post = Post.find(rand(1..Post.all.count))
  comment.save
  puts "comment created"
end
