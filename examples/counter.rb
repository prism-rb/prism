class SnabbdomComponent
  def initialize
    JS.import("https://cdn.skypack.dev/snabbdom").then do |snabbdom|
      @snabbdom = snabbdom

      window.snabbdom = @snabbdom

      @patch = snabbdom.init([
        @snabbdom.classModule,
        @snabbdom.propsModule,
        @snabbdom.attributesModule,
        @snabbdom.styleModule,
        @snabbdom.eventListenersModule,
      ])

      @container = document.body

      update_vdom
    end
  end

  def update_vdom
    vdom = render

    @patch.call(nil, @container, vdom)

    @container = vdom
  end
end

class Counter < SnabbdomComponent
  include JS::Global

  attr_reader :count

  def initialize(count)
    super()

    @initial_count = count
    @count = count
  end

  def change(amount)
    @count += amount

    update_vdom
  end

  def reset
    @count = @initial_count
  end

  def render
    @snabbdom.h("div.counter", {}, [
      @snabbdom.h("div", "Count: #{@count}"),
      @snabbdom.h("button", {on: {click: -> { change(1) }}}, "+"),
      @snabbdom.h("button", {on: {click: -> { change(-1) }}}, "-"),
    ])
  end
end

Counter.new(0)
