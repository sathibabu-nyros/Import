class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  respond_to :html, :json
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception

  after_filter  :set_csrf_cookie_for_ng


  def ensure_signup_complete
    # Ensure we don't go into an infinite loop
    return if action_name == 'finish_signup'

    # Redirect to the 'finish_signup' page if the user
    # email hasn't been verified yet
    if current_user && !current_user.email_verified?
      redirect_to finish_signup_path(current_user)
    end
  end
  

  def set_csrf_cookie_for_ng
    cookies['XSRF-TOKEN'] = form_authenticity_token if protect_against_forgery?
  end

  protected

  def verified_request?
    super || form_authenticity_token == request.headers['X-XSRF-TOKEN']
  end  
end