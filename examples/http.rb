class HttpExample < Prism::Component
  attr_accessor :name

  def initialize(name = "World")
    @name = name
  end

  def make_request
    # make a request
    target = "http://localhost:9001/"

    Http.get(target) do |response|
      puts response
    end
  end

  def render
    button(
      "Fire the Maid",
      onClick: call(:make_request)
    )
  end
end

Prism.mount(HttpExample.new)
