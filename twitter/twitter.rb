require 'bigbertha'
require 'oauth'
require 'json'

base_uri = 'https://sweltering-inferno-6192.firebaseio.com'

$ref = Bigbertha::Ref.new( 'https://sweltering-inferno-6192.firebaseio.com' )

class Controller

  def self.parse_database
    all_tweets_hash = $ref.child.read
    all_tweets_array = []
    all_tweets_hash.each do |key,value|
      all_tweets_array << [key, value]
    end
    tweet = all_tweets_array.sample
    @tweet_key = tweet.first
    @tweet_text_to_send = tweet.last["tweet_text"]
  end

  def self.run
    user_input = ARGV
    if ARGV[0] == "add"
      user_input.shift
      $ref.push({tweet_text: user_input.join(" "), sent: false})

    elsif ARGV[0] == "tweet"
      Controller.parse_database
      Tweet.send_tweet(@tweet_text_to_send)
      $ref.child( @tweet_key ).remove
    else
      p "Invalid command. Please enter 'add' or 'tweet'."
    end
  end
end

class Tweet
  def self.send_tweet(tweet)

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
      "status" => tweet #maybe comma
      )

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

Controller.run

### TEST CODE
data = {
  a: {
    tweet_text: "Tweet from firebase",
    sent: false
  }
}
# ref.push({tweet_text: "third from push", sent: false})
# ref.push({tweet_text: "second tweet from push", sent: false})
# ref.set( data )


# p ref.child( :a ).remove

__END__


firebase = Firebase::Client.new(base_uri)

response = firebase.push("todos", { :name => 'Pick the milk', :priority => 1 })
response.success? # => true
response.code # => 200
response.body # => { 'name' => "-INOQPH-aV_psbk3ZXEX" }
response.raw_body # => '{"name":"-INOQPH-aV_psbk3ZXEX"}'


# If you have a read-only namespace, set your secret key as follows:

firebase = Firebase::Client.new(base_uri, secret_key)

response = firebase.push("todos", { :name => 'Pick the milk', :priority => 1 })


# You can now pass custom query options to firebase:

response = firebase.push("todos", :limit => 1)
# So far, supported methods are:

set(path, data, query_options)
get(path, query_options)
push(path, data, query_options)
delete(path, query_options)
update(path, data, query_options)
