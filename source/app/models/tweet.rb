require 'rubygems'
require 'oauth'
require 'json'

class Tweet < ActiveRecord::Base

  # validate length
  def self.send_tweet
    next_tweet = Tweet.where(sent: false).first

    consumer_key = OAuth::Consumer.new(
  "uPa8DwaX45rblSHFIE2sNq3E1", ###CHANGE FOR NEW ACCOUNT
  "wsFEVo9iBxfzdCFiazV7HX3xyfRrPTscVy5f0iy4q5pxdPHbU2") ###CHANGE
    access_token = OAuth::Token.new(
  "2866232910-9pDxci8LleZax9dSnInktY33DCb3HW3lBUdBO9H", ###CHANGE
  "ngvAaTfGM5H78q2OTULIlWcLmZtTR2nF9nooQ9xtdExVf") ###CHANGE

    baseurl = "https://api.twitter.com"
    path    = "/1.1/statuses/update.json"
    address = URI("#{baseurl}#{path}")
    request = Net::HTTP::Post.new address.request_uri
    request.set_form_data(
      "status" => next_tweet.tweet_content)

    next_tweet.sent = true
    next_tweet.save

    # Set up HTTP.
    http             = Net::HTTP.new address.host, address.port
    http.use_ssl     = true
    http.verify_mode = OpenSSL::SSL::VERIFY_PEER

    # Issue the request.
    request.oauth! http, consumer_key, access_token
    http.start
    response = http.request request

    # Parse and print the Tweet if the response code was 200
    tweet = nil
    if response.code == '200' then
      tweet = JSON.parse(response.body)
      puts "Successfully sent #{tweet["text"]}"
    else
      puts "Could not send the Tweet! " +
      "Code:#{response.code} Body:#{response.body}"
    end

  end

end
