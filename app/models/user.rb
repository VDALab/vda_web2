class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,:confirmable
  devise :omniauthable, :omniauth_providers => [:google_oauth2]

  def self.from_omniauth(auth)
    where(email: auth.info.email.downcase).first_or_create do |user|
      user.email = auth.info.email
      user.save
    end
  end
end
