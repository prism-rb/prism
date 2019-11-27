require 'rack'
require 'rack/server'

class PrismServer
  def call(env)
    prism_path =File.expand_path("..", __dir__)
    eval(File.read("./src/server-impl.rb"), binding)
  end
end

Rack::Server.start :app => PrismServer.new
