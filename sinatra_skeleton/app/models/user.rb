class User < ActiveRecord::Base
  include BCrypt
  has_many  :comments
  has_many  :posts
  validates :email, :presence => true, :uniqueness => true
  validates :name, :presence => true, :uniqueness => true

  has_secure_password
  # def password
  #   @password ||= Password.new(password_hash)
  # end

  # def password=(new_password)
  #   @password = Password.create(new_password)
  #   self.password_hash = @password
  # end

  # # User.create(params)
  # def create
  #   @user = User.new(params[:user])
  #   @user.password = params[:password]
  #   @user.save!
  # end

  # def login
  #   @user = User.find_by_email(params[:email])
  #   if @user.password == params[:password]
  #     #create session for user, redirect
  #   else
  #     #go back to login, flash error message 
  #   end
  # end
end
