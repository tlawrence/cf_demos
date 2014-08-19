require 'mongo'
require 'json'
require 'logger'

class Mongoconfig
  attr_accessor :collection
  def initialize 
    @log = Logger.new(STDERR)
    @log.level = Logger::DEBUG
    begin
      dbcreds = JSON.parse(ENV['VCAP_SERVICES'])['mongodb-2.2'].first['credentials']
    rescue => e
      @log.error("Error Getting DB Creds From ENV")
      exit
    end


    @mongo = Mongo::MongoClient.from_uri(dbcreds['url'])[dbcreds['db']]['instances']
    

  end

  def register
    instance_info = JSON.parse(ENV['VCAP_APPLICATION'])
     
    @mongo.drop if instance_info['instance_index'] == 0

    @log.info("Instance ID: #{instance_info['instance_id']} Intance Index: #{instance_info['instance_index']}")

    @log.info("Registering Instance In MongoDB")
    @mongo.insert({:instance_id => instance_info['instance_id'], :instance_index => instance_info['instance_index']} )

    @log.info("There Are #{@mongo.count} Docs In The Collection")
  end



  def deregister
    @mongo.remove({"instance_id" => instance_info['instance_id']})
    @log.info("DeRegistering Instance From MongoDB")
  end

  def collection
    @mongo
  end
end
