require './app.rb'
require './mongo/mongo.rb'


mongo = Mongoconfig.new
mongo.register

run Scaledemo

(1..30).each do |i|
  Signal.trap(i) {mongo.deregister}
end


