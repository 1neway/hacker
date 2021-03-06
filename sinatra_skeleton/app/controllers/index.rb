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
  @posts = Post.ask.order("created_at DESC")
  erb :index#add ask scope to post model
end

get '/submit' do
  if session[:id]
    erb :submit
  else
    erb :login_create
  end
end

get '/user/:id' do
  @user = User.find(params[:id])
  erb :profile
end

get '/submissions/:id' do
  if @posts
    @posts = Post.find_by_user_id(params[:id])
    @posts.order("created_at DESC")
  end
  erb :index
end

get '/comments/:id' do
  if @comments
    @comments = Comment.find_by_user_id(params[:id])
    @comments.order("created_at DESC")
  end
  erb :index
end

get '/logout' do
  session.clear
  redirect to('/')
end

post '/register' do
  user = User.new(name: params[:name], email: params[:email], password: params[:password], password_confirmation: params[:password_confirmation])
  user.save 
  user.errors.each do |error| puts error end
  if user.id
    session[:id] = user.id
    redirect to('/submit')
  else
    # flash[:error] = "Account create failed, here's why; #{user.errors.each{|error| error }}"
    redirect to ('/submit')
  end  
end

post '/submit' do
  if params[:url]
    post = Post.new(title: params[:title], url: params[:url])
    post.save
    redirect to('/new')
  elsif params[:comment]
    post = Post.new(title: params[:title], user_id: session[:id], ask: 1)
    comment = Comment.new(content: params[:content], user_id: session[:id])
    comment.save
    post.save
    post.comments << comment
    redirect to('/new')
  else
    # flash[:error] = "You fucked up!"
    redirect to('/submit') 
  end
end

post '/login' do
  user = User.find_by_name(params[:name])
  if user
    session[:id] = user.id
    redirect to('/submit')
  else
    # flash[:error] = "You fucked up!"
    redirect to('/submit')
  end
end
