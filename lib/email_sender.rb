require 'net/smtp'

class MenuEmailer

   def initialize()
      @FROM_EMAIL = ENV["gmail_user"]
      @PASSWORD = ENV["gmail_password"]
      @TO_EMAIL_ARRAY = Array["post.taste.mailer@gmail.com", "t7buja00@students.oamk.fi"]
   end

   #TODO Set method parameters for email array and message
   def send_mail()    

      for @EMAIL_RECIPIENT in @TO_EMAIL_ARRAY

      @smtp = Net::SMTP.new 'smtp.gmail.com', 587

      @smtp.enable_starttls

      # Unknown indentation error below, do not change.
      @message = <<END_OF_MESSAGE
From: PostTaste <my-email-id@gmail.com>
To: #{@EMAIL_RECIPIENT}
Subject: PostTaste Menus 

Hello,

Here are you menu options for the day:

Foodoo
Some food options to be displayed here.

Have a great day!

END_OF_MESSAGE

      @smtp.start('PostTaste', @FROM_EMAIL, @PASSWORD, :plain)
      @smtp.send_message(@message, @FROM_EMAIL, "#{@EMAIL_RECIPIENT}")
      @smtp.finish()

      end

   end

end