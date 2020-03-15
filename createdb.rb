# Set up for the application and database. DO NOT CHANGE. #############################
require "sequel"                                                                      #
connection_string = ENV['DATABASE_URL'] || "sqlite://#{Dir.pwd}/development.sqlite3"  #
DB = Sequel.connect(connection_string)                                                #
#######################################################################################

# Database schema - this should reflect your domain model

# New domain model - adds users
DB.create_table! :events do
  primary_key :id
  String :title
  String :description, text: true
  String :date
  String :location
  String :level
  String :price
end
DB.create_table! :rsvps do
  primary_key :id
  foreign_key :event_id
  foreign_key :user_id
  Boolean :going
  String :comments, text: true
end
DB.create_table! :users do
  primary_key :id
  String :name
  String :email
  String :password
end

# Insert initial (seed) data
events_table = DB.from(:events)

events_table.insert(title: "Billy’s English Bootcamp", 
                    description: "Hardcore English lesson modeled after U.S. army training!! “Who’s the boss? Is it English, or is it you?",
                    date: "Jan 1",
                    location: "Billy's army base",
                    level: "Hardcore", 
                    price: "$500 per lesson")

events_table.insert(title: "Cooking and English conversation with Amy", 
                    description: "You can learn cooking and English at the same time!",
                    date: "December 23",
                    location: "Amy's place",
                    level: "Beginner", 
                    price: "$200 per lesson")

puts "Success!"