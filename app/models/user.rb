class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable


  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :provider, :uid, :uname
  # attr_accessible :title, :body
  has_many :tweetlists

  def self.find_for_twitter_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    if user
      return user
    else
      registered_user = User.where(:email => auth.extra.raw_info.screen_name + "@twitter.com").first
      if registered_user
        return registered_user
      else
        user = User.create( provider:auth.provider,
                            uid:auth.uid,
                            uname: auth.extra.raw_info.screen_name,
                            email: auth.extra.raw_info.screen_name+"@twitter.com",
                            password:Devise.friendly_token[0,20],
                          )
      end

    end
  end
end
