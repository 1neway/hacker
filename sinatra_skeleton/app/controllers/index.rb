get '/' do
  # Look in app/views/index.erb
  @posts = Post.all
  erb :index
end

get '/new' do
  @posts = Post.all.order("id DESC")
  erb :index
end

get '/comments' do
  @comments = Comment.all.order("id DESC")
  erb :index
end

get '/ask' do 
  #add ask scope to post model
end

get '/submit' do
  if session[:id]
    erb :submit
  else
    erb :login_create
  end
end

post '/register' do
  user = User.new(name: params[:name], password: params[:password], password_confirmation: params[:password_confirmation])
  user.save 
  if user.id
    session[:id] = user.id
    redirect to('/')
  else
    flash[:error] = "Account create failed, here's why; #{user.errors.each{|error| error }}"
    redirect to ('/submit')
  end  
end

post 

post '/submit' do
  if params[:url]
    post = Post.new(title: params[:title], url: params[:url])
    redirect to('/new')
  elsif params[:comment]
    post = Post.new(title: params[:title], user_id: session[:id], ask: 1)
    comment = Comment.new(content: params[:content], user_id: session[:id])
    comment.save
    post.save
    post.comments << comment
    redirect to('/new')
  else
    flash[:error] = "You fucked up!"
    redirect to('/submit') 
  end
end
