class HTTPExample < Prism::Component
  TARGET = "http://localhost:9001/"

  attr_accessor :name

  def initialize(name = "World")
    @name = name
    @status = nil
  end

  def make_request
    @status = "Loading..."

    HTTP.get(TARGET) do |response|
      @status = response.body
    end
  end

  def render
    div([
      button(
        "Make request!",
        onClick: call(:make_request)
      ),
      div("Result: #{@status || 'Not yet loaded'}")
    ])
  end
end

Prism.mount(HTTPExample.new)
