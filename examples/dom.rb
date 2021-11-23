class DOMExample < Prism::Component
  include JS::Global

  def initialize()
    document.body.addEventListener("keydown") { |event| puts "keydown: #{event.key}" }

    window.setTimeout(-> { puts "timeout fired!" }, 1000)

    document.body.style.background = "red"

    puts window.location.href
  end

  def alert
    window.alert("Wow this works!")
  end

  def call_fetch
    window.fetch('https://google.com')
  end

  def change_color(value)
    document.body.style.background = value
  end

  def render
    div(".dom-example", {}, [
      button({:onClick => call(:alert)}, [text("Alert")]),
      button({:onClick => call(:call_fetch)}, [text("Fetch")]),
      input(onInput: call(:change_color).with_target_data(:value))
    ])
  end
end

Prism.mount(DOMExample.new() {})
