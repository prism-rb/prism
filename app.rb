class Counter
  include Prism::DOM

  attr_reader :count

  def initialize(count)
    @count = count
  end

  def change(amount)
    @count += amount
  end

  def reset
    @count = 0
  end

  def render
    div(".counter", {}, [
      div("", {}, [text(count)]),
      button("", {:onClick => dispatch(:change, 1)}, [text("+")]),
      button("", {:onClick => dispatch(:change, -1)}, [text("-")]),
      button("", {:onClick => dispatch(:reset)}, [text("Reset")])
    ])
  end
end

Prism.mount(Counter.new(0))
