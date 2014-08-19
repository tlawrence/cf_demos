task :default => [:push]

task :push do
  puts "Logging In To CF"
  sh "cf login -a api.beta.cf.skyscapecloud.com -u test -p test"
  puts "Pushing App"
  sh "cf push travis_test"
end


