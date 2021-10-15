class Counter < Prism::Component
  attr_reader :count

  def initialize(count, &remove)
    @initial_count = count
    @count = count
    @remove = remove
  end

  def change(amount)
    @count += amount
  end

  def reset
    @count = @initial_count
  end

  def remove
    @remove.call
  end

  def alert
    window.alert("Wow this works! THe count is #{@count}")
  end

  def render
    div(".counter", {}, [
      div("", {}, [count.to_s]),
      button({:onClick => call(:change).with(+1)}, [text("+")]),
      button({:onClick => call(:change).with(-1)}, [text("-")]),
      button({:onClick => call(:reset)}, [text("Reset")]),
      button({:onClick => call(:remove)}, [text("Delete")]),
      button({:onClick => call(:alert)}, [text("Alert")])
    ])
  end
end

Prism.mount(Counter.new(0) {})
