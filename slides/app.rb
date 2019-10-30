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
      div("", {}, [count.to_s]),
      button({:onClick => call(:change).with(+1)}, [text("+")]),
      button({:onClick => call(:change).with(-1)}, [text("-")]),
      button({:onClick => call(:reset)}, [text("Reset")]),
      button({:onClick => call(:remove)}, [text("Delete")])
    ])
  end
end

class CounterListSlide < Prism::Component
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
    div(".slide", [
      div('.counter-list', [
        div('.controls', [button({:onClick => call(:add)}, "add counter")]),
        div('.counters', @counters)
      ])
    ])
  end
end

class HelloRubyDrawnSlide < Prism::Component
  attr_accessor :name

  def initialize
    @name = "World"
  end

  def render
    div(".slide.name", [
      img('.what-is-your-name', props: {src: 'assets/slide22-hello-name-top.svg'}),
      drawn_input,
      div('.greeting', name.length > 0 ? "Hello, #{name}!" : "Enter your name!")
    ])
  end

  def drawn_input
    div(".drawn-input", [
      img(props: {src: 'assets/slide22-hello-name-background.svg'}),
      input(
        onKeydown: call(:name=).with_target_data(:value).stop_propagation,
        onInput: call(:name=).with_target_data(:value).stop_propagation,
        props: {value: name}
      ),
      img(props: {src: 'assets/slide22-hello-name-box.svg'})
    ])
  end
end

class TodoListSlide < Prism::Component
  attr_accessor :new_todo
  attr_reader :items

  def initialize
    @items = []
  end

  def add_todo_item
    item = TodoItem.new(new_todo) { @items.delete(item) }

    items << item

    @new_todo = ""
  end

  def remove_completed
    @items.reject!(&:completed?)
  end

  def keydown(key, value)
    if key == "Enter"
      add_todo_item
    else
      self.new_todo = value
    end
  end

  def drawn_input
    div(".drawn-input", [
      img(props: {src: 'assets/slide22-hello-name-background.svg'}),
      input(
        onKeydown: call(:keydown).with_event_data(:key).with_target_data(:value).stop_propagation,
        onInput: call(:new_todo=).with_target_data(:value).stop_propagation,
        props: {value: new_todo}
      ),
      img(props: {src: 'assets/slide22-hello-name-box.svg'})
    ])
  end

  def render
    div(".slide", [
      div(".todo-list", [
        img(props: {src: 'assets/todo-static.svg'}),
        drawn_input,
        div(".todo-list-items", items)
      ])
    ])
  end

  private

  class TodoItem < Prism::Component
    attr_reader :todo

    def initialize(todo, &block)
      @todo = todo
      @completed = false
      @remove = block
    end

    def toggle_complete
      @completed = !@completed
    end

    def completed?
      @completed
    end

    def remove
      @remove.call
    end

    def render
      div(".todo-item", [
        div('.complete', {onClick: call(:toggle_complete)}, [
          img(props: {src: 'assets/todo-circle.svg'}),
          img(props: {src: 'assets/todo-tick.svg'}, style: {display: completed? ? 'block' : 'none'})
        ]),
        div(".text", [text(@todo)]),
        img(".trash", props: {src: 'assets/todo-trash.svg'}, onClick: call(:remove)),
      ])
    end
  end
end


class Slides < Prism::Component
  attr_reader :slides

  def initialize
    @slides = [
      image_slide("title.svg", "title"),
      image_slide('slide1-i-learned-ruby.svg', "learned-ruby"),
      image_slide('slide2-i-learned-js.svg', "learned-svg"),
      image_slide('slide3-i-fell-in-love-with-the-browser.svg', "love-the-browser"),
      image_slide('slide4-ruby-advantages.svg', "ruby-advantages"),
      image_slide('slide4-what-if-we-could-use-ruby.svg', "what-if-we-could-use-ruby"),
      image_slide('slide6-problem1.svg', 'problem1'),
      image_slide('slide7-emscripten.svg', 'emscripten-slide'),
      image_slide('slide8-problem2.svg', 'problem2',),
      image_slide('slide9-matz-to-the-rescue.svg', 'matz-rescue'),
      image_slide('slide10-problem3.svg', 'problem3'),
      image_slide('slide11-a-wild-webassembly-appears.svg', 'wasm-appears'),
      image_slide('slide12-what-a-browser-do.svg', 'what-a-browser-do'),
      image_slide('slide13-parse-optimize-generate.svg', 'pog'),
      image_slide('slide14-what-if-we-could-just.svg', 'what-if-we-could-just'),
      image_slide('slide15-now-youre-cooking.svg', 'now-youre-cooking'),
      image_slide('slide16-only-one-problem-left.svg', 'only-one-problem-left'),
      image_slide('slide17-what-good-is-an-app-that-only-logs.svg', 'what-good'),
      image_slide('architecture-old.svg', 'architecture'),
      image_slide('slide19-the-same-again-but-better.svg', 'same-but-better'),
      image_slide('architecture-new.svg', 'architecture'),
      image_slide('slide20-presenting-prism.svg', 'presenting-prism'),
      image_slide('slide21-enough-talk-lets-dance.svg', 'lets-dance'),
      HelloRubyDrawnSlide.new,
      TodoListSlide.new,
      image_slide('slide23-demo-time.svg', 'demo-time'),
      image_slide('slide24-yay.svg', 'yay'),
      image_slide('slide25-yak-shaving.svg', 'yak-shaving'),
      image_slide('slide26-but-what-about.svg', 'but-what-about'),
      image_slide('slide27-we-did-it.svg', 'we-did-it'),
      image_slide('sustainable.svg', 'sustainable'),
      image_slide('shameless-promotion.svg', 'shameless-promotion'),
      image_slide('hello-raygun.svg', 'hello-raygun'),
      image_slide('slide28-thanks.svg', 'thanks'),
    ]

    @index = 0

    DOM.select('document').on('keydown') do |event|
      keydown(event["key"])
    end
  end

  def slide(content)
    div(".slide", [h2("", content)])
  end

  def image_slide(src, className = "")
    classes = {}
    classes[className] = true
    div(".slide", {class: classes}, [img(props: {src: "assets/#{src}"})])
  end


  def previous_slide
    @index -= 1 unless first_slide?
  end

  def next_slide
    @index += 1 unless last_slide?
  end

  def keydown(key)
    case key
    when "ArrowRight", " "
      next_slide
    when "ArrowLeft"
      previous_slide
    end
  end

  def render
    div(".slides", [
      img(
        ".control",
        onClick: call(:previous_slide),
        props: {src: "assets/prev.svg"},
        class: {hidden: first_slide?}
      ),
      current_slide,
      img(
        ".control",
        onClick: call(:next_slide),
        props: {src: "assets/next.svg"},
        class: {hidden: last_slide?}
      )
    ])
  end

  private

  def last_slide?
    (@index + 1) >= slides.length
  end

  def first_slide?
    @index == 0
  end

  def current_slide
    slides[@index]
  end
end

Prism.mount(Slides.new)
