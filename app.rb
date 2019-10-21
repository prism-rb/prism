class Counter < Prism::Component
  attr_reader :count

  def initialize(count, &remove)
    @count = count
    @remove = remove
  end

  def change(amount)
    @count += amount
  end

  def reset
    @count = 0
  end

  def remove
    @remove.call
  end

  def render
    div(".counter", {}, [
      div("", {}, [text(count)]),
      button("", {:onClick => dispatch(:change, 1)}, [text("+")]),
      button("", {:onClick => dispatch(:change, -1)}, [text("-")]),
      button("", {:onClick => dispatch(:reset)}, [text("Reset")]),
      button("", {:onClick => dispatch(:remove)}, [text("Delete")])
    ])
  end
end

class Slides < Prism::Component
  def initialize
    @counters = [make_counter]
  end

  def add
    @counters << make_counter
  end

  def make_counter
    c = Counter.new(0) { @counters.delete(c) }
  end

  def render
    div(".slides", [
      div('.controls', [button({:onClick => dispatch(:add)}, "add counter")]),
      div('.counters', @counters)
    ])
  end
end

Prism.mount(Slides.new)
