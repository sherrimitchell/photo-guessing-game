class UsersController < ApplicationController
  before_action :authenticate_with_token!, only: [:get_user, :delete_user]

  def register
    passhash = self.password_encryption(params[:password])
    @user = User.new(user_name: params[:user_name],
                      first_name: params[:first_name],
                      last_name: params[:last_name],
                      email: params[:email],
                     password: passhash)
    if @user.save
      render 'register.json.jbuilder', status: :created
    else 
      render json: { errors: @user.errors.full_messages },
      status: :unprocessable_entity
    end
  end

  def login
    passhash = self.password_encryption(params[:password])
    @user = User.find_by(user_name: params[:user_name], password: passhash)
    if @user
      render 'login.json.jbuilder', status: :created
    else 
      render json: { message: 'The username or password you supplied is incorrect.' },
        status: :unprocessable_entity
    end
  end

  def get_users
    @users = User.order(created_at: :desc).page(params[:page])
    if @users.any?
      render 'users.json.jbuilder', status: :ok
    else
      render json: { message: 'There are no users to display.' },
        status: :unprocessable_entity
    end
  end

  def get_user
    @user = current_user
    render 'user.json.jbuilder', status: :ok
  end

  def delete_user
    passhash = self.password_encryption(params[:password])
    if passhash == current_user.password
      current_user.destroy
      render json: { message: 'User has been deleted'},
        status: :ok
    else
      render json: { message: 'Password you supplied is not correct' }
    end
  end

  protected
  def password_encryption(password)
    if !password.nil? && password != ""
      result = Digest::SHA1.hexdigest(password)
    else
      result = nil
    end
    result
  end

end
