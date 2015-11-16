class UsersController < ApplicationController
	

	def checkuser
  	 @count = User.where(:email =>params[:email]).count   
      render json: @count, status: :ok  
   end

end
