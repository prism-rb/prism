module Prism
  class Mount
    def initialize(component)
      @component = component
    end
  
    def render
      JSON::stringify(@component.render)
    end
  
    def dispatch(messageJSON)
      message = JSON::parse(messageJSON)
  
      instance = Prism.instances[message["instance"]]
  
      if instance.respond_to? message["type"]
        instance.send(message["type"], *message["args"])
      else
        raise "Component #{instance.class} has no method ##{message["type"]}"
      end
    end
  
    def event(eventJSON, id)
      DOM.event(JSON::parse(eventJSON), id)
    end
  
    def http_response(responseJSON, id)
      HTTP._response(HTTP::Response.from_json(responseJSON), id)
    end
  end
end