class User < ActiveRecord::Base
  # Include default devise modules. Others available are:

  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable



def self.form_oauth oauth,data

     data = oauth.get_data
    
   
    puts "------------#{data}---------------"

   
  

    user = find_by(oauth.provider => data[:id]) || find_or_create_by(email: data[:email]) do |u|
      u.password =  SecureRandom.hex
    end

    if user.present? && !user.display_name.present?
    user.update(
      display_name: oauth.get_names.join(' '),
      email: data[:email],
      oauth.provider => data[:id]
    )
    end
    user
  end


  def displayName= name
    self.display_name = name
  end
  
end
