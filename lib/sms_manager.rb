# Configure your SMS API settings 
require 'net/http'

class SmsManager
  attr_accessor :recipients, :message
#http://api.clickatell.com/http/sendmsg?user=yogesh4982&password=PASSWORD&api_id=3269563&to=919833435504&text=Message

  SMS_URL = 'http://api.clickatell.com/http/sendmsg' # API URL
  USERNAME = 'yogesh4982'
  PASSWORD = 'tata123'
  API_ID='3269563'

  def initialize(message, recipients)
    @recipients = recipients
    @message = CGI::escape message
  end

  def send_sms
  puts(">>>>>>>>>>>>>>>>>>>>>>>> Sending SMS to "  )
    request = "#{SMS_URL}?user=#{USERNAME}&password=#{PASSWORD}&api_id=#{API_ID}&text=#{@message}&to="
puts(request)
    cur_request = request
    @recipients.each do |recipient|
      if cur_request.length > 1000
        response = Net::HTTP.get_response(URI.parse(cur_request))
	puts("Response received >>>>>>>>>>>>>>>>>>>>>>>>>" +response)
        cur_request = request
      end
      cur_request += ",#{recipient}"
    end

    if request.length < cur_request.length
      response = Net::HTTP.get_response(URI.parse(cur_request))
    end
    cur_request
    #response_string = response.split
    if response.body =~ /Your message is successfully/
      sms_count = Configuration.find_by_config_key("TotalSmsCount")
      new_count = sms_count.config_value.to_i+@recipients.size
      Configuration.update(sms_count.id,:config_value=>new_count.to_s)
    end
  end

end