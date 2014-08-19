require 'sinatra/base'
require './mongo/mongo.rb'
require 'logger'

class Scaledemo < Sinatra::Base

  def initialize
    @mongo = Mongoconfig.new
    super
  end

  get '/' do

    body = ""
    @mongo.collection.find.each { |doc| body << "Instance: #{doc['instance_index']} Id: #{doc['instance_id']}" }
    body
  end

  def self.pre
    @pre = "I happened on startup"
    puts @pre
  end

  def self.cleanup
    @post = "I happened on shutdown"
    puts @post
  end

end
