require 'src/prism/component.rb'
require 'src/prism/mount.rb'
require 'src/prism/event_handler.rb'

module Prism
  @@instances = {}

  def self.instances
    @@instances
  end

  def self.mount(component)
    Mount.new(component)
  end
end

module DOM
  @@event_id = 0
  @@listeners = {}

  def self.get_event_id
    @@event_id += 1

    @@event_id.to_s
  end

  def self.add_listener(id, &block)
    @@listeners[id] = block
  end

  def self.select(selector)
    ElementSelection.new(selector)
  end

  def self.event(eventData, id)
    @@listeners[id].call(eventData)
  end

  class ElementSelection
    def initialize(selector)
      @selector = selector
    end

    def on(eventName, &block)
      id = DOM.get_event_id
      InternalDOM.add_event_listener(@selector, eventName, id)
      DOM.add_listener(id, &block)
    end
  end
end

module HTTP
  @@event_id = 0
  @@listeners = {}

  def self.get_event_id
    @@event_id += 1

    @@event_id.to_s
  end

  def self.add_listener(id, &block)
    @@listeners[id] = block
  end

  def self.get(url, &block)
    id = HTTP.get_event_id

    InternalHTTP.http_request(url, id)

    HTTP.add_listener(id, &block)
  end

  def self._response(text, id)
    @@listeners[id].call(text)
  end

  class Response < Struct.new(:body)
    def self.from_json(json)
      data = JSON::parse(json)

      new(data["body"])
    end
  end
end
