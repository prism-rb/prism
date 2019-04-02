module Prism
  def div(*args)
    options, children = *args

    if options.is_a? Array
      children = options
      options = {}
    end

    options = options || {}
    options[:type] = "div"
    options[:children] = children || []

    options
  end

  def button(*args)
    options, children = *args

    if options.is_a? Array
      children = options
      options = {}
    end

    options = options || {}
    options[:type] = "button"
    options[:children] = children || []

    options
  end

  def text(t)
    {:type => "text", :content => t.to_s}
  end
end

class Counter
  include Prism

  def initialize
    @count = 0
  end

  def render
    div({:class => "counter"}, [
      div([text(@count)]),
      button([text("+")]),
      button([text("-")])
    ])
  end

  def increase
    @count += 1

    render
  end
end

puts JSON.generate(Counter.new.render)
