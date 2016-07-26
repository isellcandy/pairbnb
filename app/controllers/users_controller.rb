class UsersController < ApplicationController
	def homepage
	end

	def show
		@user = User.find(params[:id])
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		if @user.update(user_params)
			respond_to do |format|
				format.html { redirect_to user_path(@user) }
				format.js
			end
		end
	end

	private

	def user_params
		params.require(:user).permit(:fullname, :username, :email, {avatars:[]}) 
	end
end
