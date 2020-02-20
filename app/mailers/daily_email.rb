class SendDailyMenu
    def run
      @users = User.all
      @users.each do |user|     
        UserMailer.with(email: user.email).daily_summary.deliver_now
        puts user.email
      end
    end
  end