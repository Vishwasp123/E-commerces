class UsersController < ApplicationController

 rescue_from ActiveRecord::RecordInvalid, with: :handle_invalid_record
 skip_before_action :verify_authenticity_token


	def index  
		@users = User.all 
		render json: @users 
	end

 def create 
	 	@user = User.create!(user_params)
	 	@token  = encode_token(user_id: @user.id)
	 	render json: { user: { id: @user.id, email: @user.email }, token: @token } , status: :created
 end

  def show 
    render json: current_user, status: :ok
  end

 	private 

 def user_params
 	params.permit(:email, :password)
 end

 def handle_invalid_record(e)
 	render json: { errors: e.record.errors.full_messages }
 end
end
