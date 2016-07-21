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
			render :homepage
			flash[:success] = "Updated profile successfully"
		else
			flash[:danger] = "Profile update fail"
		end
	end

	private

	def user_params
		params.require(:user).permit(:fullname, :username, :email) 
	end
end
