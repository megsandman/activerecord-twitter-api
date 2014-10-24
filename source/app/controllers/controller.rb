
class Controller
  def self.run
    user_input = ARGV

    if ARGV[0] == "add"
      user_input.shift
      Tweet.create(tweet_content: user_input.join(" "))
    elsif ARGV[0] == "tweet"
      Tweet.send_tweet
    else
      p "Invalid command. Please enter 'add' or 'tweet'."
    end
  end
end
