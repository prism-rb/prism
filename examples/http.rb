
class HTTPExample < Prism::Component
  TARGET = "http://localhost:9001/"

  def initialize
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
