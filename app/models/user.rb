class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable
         
  def self.find_for_twitter_oauth(auth, signed_in_resource=nil, email, mail_frequency)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    unless user
        tw_user = Twitter::Client.new(
                          :consumer_key => "YOUR TWITTER CONSUMER KEY",
                          :consumer_secret => "YOUR TWITTER CONSUMER SECRET",
                          :oauth_token => auth.credentials.token,
                          :oauth_token_secret => auth.credentials.secret
                          )
        
        user = User.create(name: auth.extra.raw_info.name,
                           provider: auth.provider,
                           uid: auth.uid,
                           email: email,
                           password: Devise.friendly_token[0,20],
                           twitter_oauth_token: auth.credentials.token, 
                           twitter_oauth_token_secret: auth.credentials.secret,
                           mail_frequency: mail_frequency,
                           recieve_emails: true, 
                           follower_ids: tw_user.follower_ids.attrs[:ids].inject{|str,x| str.to_s + "," + x.to_s}
                           )

    else
        user.update(:twitter_oauth_token => auth.credentials.token, :twitter_oauth_token_secret => auth.credentials.secret)
    end


    user
  end
  
  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end
  
end
