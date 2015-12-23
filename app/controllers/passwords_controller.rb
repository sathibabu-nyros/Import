class PasswordsController < Devise::PasswordsController

	def update
		if params[:token].present?
			@user = User.where(:reset_password_token => params[:token]).first
			if @user.present?				
				@user.update_attributes(:password => params[:password_confirmation])
			end			
		end
		 render json: @user
	end

	protected
    
    def after_resetting_password_path_for(resource)
      root_path
    end

    # The path used after sending reset password instructions
    def after_sending_reset_password_instructions_path_for(resource_name)
      root_path
    end

end
