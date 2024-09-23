class SessionsController < ApplicationController
	skip_before_action :verify_authenticity_token

	rescue_from ActiveRecord::RecordNotFound, with: :handle_record_not_found

	def login 
	  @user = User.find_by!(email: login_params[:email])
	  if @user.authenticate(login_params[:password])
	    @token = encode_token(user_id: @user.id)  # Fixed this line
	    render json: { user: { id: @user.id, email: @user.email }, token: @token }, status: :ok
	  else 
	    render json: { error: "Invalid email or password" }, status: :unauthorized
	  end
	end


	def login_params
	 params.permit( :password, :email)
	end

	def handle_record_not_found(e)
		render json: {message: "User doesn't exist"}, status: :unauthorized
	end
end
