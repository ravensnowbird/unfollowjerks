class UserMailer < ActionMailer::Base
  default :from =>  "noreply@unfollowjerks.com"
  def send_email(user, unfollower_ids)
    @user = user
    @unfollower_ids  = unfollower_ids
    mail(to: @user.email, subject: @unfollower_ids.count.to_s + " people have unfollowed you this " + (user.mail_frequency == "weekly" ? "week" : "month"))
  end
end