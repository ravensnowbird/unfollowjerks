desc "Weekly Task"
task :check_unfollowers_weekly => :environment do
  if Date.today.sunday?
    User.where(:mail_frequency => "weekly", :recieve_emails => true).each do |user|
      tw_user = Twitter::Client.new(
      :consumer_key => "YBGQxvNHGkUkdqKv1NauA",
      :consumer_secret => "9TOC0lqKnkG9DpUV2TtdAPch9hK95WSUCY6NZKWLzI",
      :oauth_token => user.twitter_oauth_token,
      :oauth_token_secret => user.twitter_oauth_token_secret
      )
      tw_user_ids = tw_user.follower_ids.attrs[:ids]
      user_ids = user.follower_ids.split(",").collect{|x| x.to_i }

      unfollower_ids = user_ids - ( user_ids &  tw_user_ids)
      user.update(:follower_ids => tw_user_ids.inject{|str,x| str.to_s + "," + x.to_s})

      unless unfollower_ids.blank?
        UserMailer.send_email(user, unfollower_ids).deliver!
      end
    end
  end
end

desc "Monthly Task"
task :check_unfollowers_monthly => :environment do
  if Date.today.day == 1
    User.where(:mail_frequency => "monthly", :recieve_emails => true).each do |user|
      tw_user = Twitter::Client.new(
      :consumer_key => "YBGQxvNHGkUkdqKv1NauA",
      :consumer_secret => "9TOC0lqKnkG9DpUV2TtdAPch9hK95WSUCY6NZKWLzI",
      :oauth_token => user.twitter_oauth_token,
      :oauth_token_secret => user.twitter_oauth_token_secret
      )
      tw_user_ids = tw_user.follower_ids.attrs[:ids]
      user_ids = user.follower_ids.split(",").collect{|x| x.to_i }

      unfollower_ids = user_ids - ( user_ids &  tw_user_ids)
      user.update(:follower_ids => tw_user_ids.inject{|str,x| str.to_s + "," + x.to_s})

      unless unfollower_ids.blank?
        UserMailer.send_email(user, unfollower_ids).deliver!
      end
    end
  end
end

desc "Minute Task"
task :check_unfollowers_every_minute => :environment do
    User.where(:mail_frequency => "weekly", :recieve_emails => true).each do |user|
      tw_user = Twitter::Client.new(
      :consumer_key => "YBGQxvNHGkUkdqKv1NauA",
      :consumer_secret => "9TOC0lqKnkG9DpUV2TtdAPch9hK95WSUCY6NZKWLzI",
      :oauth_token => user.twitter_oauth_token,
      :oauth_token_secret => user.twitter_oauth_token_secret
      )
      tw_user_ids = tw_user.follower_ids.attrs[:ids]
      user_ids = user.follower_ids.split(",").collect{|x| x.to_i }

      unfollower_ids = user_ids - ( user_ids &  tw_user_ids)
      user.update(:follower_ids => tw_user_ids.inject{|str,x| str.to_s + "," + x.to_s})

      unless unfollower_ids.blank?
        puts "Sending mail to - " + user.email.to_s
        UserMailer.send_email(user, unfollower_ids).deliver!
      end
    end
end