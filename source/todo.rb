require_relative 'config/application'

puts "Put your application code in #{File.expand_path(__FILE__)}"

`ruby app/controllers/Controller_Todo.rb ARGV'
