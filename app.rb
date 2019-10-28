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
      button({:onClick => dispatch(:change, 1)}, [text("+")]),
      button({:onClick => dispatch(:change, -1)}, [text("-")]),
      button({:onClick => dispatch(:reset)}, [text("Reset")]),
      button({:onClick => dispatch(:remove)}, [text("Delete")])
    ])
  end
end

class TitleSlide < Prism::Component
  def render
    div(".slide", [
      h1("Your Browser on Ruby")
    ])
  end
end

class BodySlide < Prism::Component
  def render
    div(".slide", [
      h3("A slide title"),
      p("A big ol body with lots of stuff wow this goes on so long."),
    ])
  end
end

ART = [
  "
  /----\\
  |    |
  |
  |
  |
  |
  |
  ----------
  ",
  "
  /----\\
  |    |
  |    o
  |
  |
  |
  |
  ----------
  ",
  "
  /----\\
  |    |
  |    o
  |    |
  |
  |
  |
  ----------
  ",
  "
  /----\\
  |    |
  |    o
  |    |\\
  |
  |
  |
  ----------
  ",
  "
  /----\\
  |    |
  |    o
  |   /|\\
  |
  |
  |
  ----------
  ",
  "
  /----\\
  |    |
  |    o
  |   /|\\
  |   /
  |
  |
  ----------
  ",
  "
  /----\\
  |    |
  |    o
  |   /|\\
  |   / \\
  |
  |
  ----------
  "
]

class HangmanSlide < Prism::Component
  attr_reader :answer
  attr_reader :guesses
  attr_accessor :artnumber

  def initialize
    restart
  end

  def make_guess(guess)
    alphabet = [*"a".."z"]

    if guesses.include?(guess)
        @feedback = "You've already guessed that"
        return
    end

    if alphabet.include?(guess)
      guesses << guess
      if answer.chars.include?(guess)
        @feedback = "Nice"
      else
        @feedback = "Wrong"
        @artnumber += 1
      end
    else
      @feedback = "Invalid"
    end
  end

  def restart
    @answer = "kiwiruby"
    @artnumber = 0
    @guesses = []
    @feedback = ""
  end

  def render
    div('.slide', [
      ascii_art,
      div('.letters', [*'a'..'z'].map { |char|
        button(
          char,
          onClick: dispatch(:make_guess, char),
          props: {disabled: guesses.include?(char) || game_over?}
        )
      }),
      button('.restart', 'Restart', onClick: dispatch(:restart))
    ])
  end

  private

  def ascii_art
    output = ""

    output += ART[artnumber] + "\n"

    output += answer.chars
      .map { |char| if guesses.include?(char) then char else "_" end }
      .join(" ")

    output += "\n"

    @feedback = "You won!!!" if won?
    @feedback = "Game over :(\nThe word was: #{answer}" if lost?

    output += "\n" + @feedback + "\n"

    pre([
      text(output.chomp)
    ])
  end

  def game_over?
    won? || lost?
  end

  def won?
    answer.chars.all? { |char| guesses.include?(char) }
  end

  def lost?
    artnumber>=6
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
        div('.controls', [button({:onClick => dispatch(:add)}, "add counter")]),
        div('.counters', @counters)
      ])
    ])
  end
end

class HelloRubySlide < Prism::Component
  attr_accessor :name

  def initialize
    @name = "World"
  end

  def render
    div(".slide", [
      input(onInput: dispatchWith(:value, :name=), props: {value: name}),
      h3("Hello, #{name}!")
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
      div(".drawn-input", [
        img(props: {src: 'assets/slide22-hello-name-background.svg'}),
        input(onInput: dispatchWith(:value, :name=), props: {value: name}),
        img(props: {src: 'assets/slide22-hello-name-box.svg'})
      ]),
      h3(name.length > 0 ? "Hello, #{name}!" : "Enter your name!")
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

  def render
    div(".slide", [
      div(".todo-list", [
        input(".new-todo", onInput: dispatchWith(:value, :new_todo=), props: {value: new_todo}),
        div(".controls", [
          button(".add-todo", "Add Todo Item", onClick: dispatch(:add_todo_item)),
          button("Remove Completed", onClick: dispatch(:remove_completed))
        ]),
        div(".summary", "#{items.count} items, #{items.select(&:completed?).count} completed"),
        div(".todo-list-items", items)
      ])
    ])
  end

  private

  class TodoItem < Prism::Component
    attr_reader :todo
    attr_writer :completed

    def initialize(todo, &block)
      @todo = todo
      @completed = false
      @remove = block
    end

    def completed?
      @completed
    end

    def remove
      @remove.call
    end

    def render
      div(".todo-item", [
        input(
          '.complete',
          props: {type: 'checkbox', checked: @completed},
          onChange: dispatchWith(:checked, :completed=)
        ),
        span(
          [text(@todo)],
          style: {
            "text-decoration": (
              if completed?
              then "line-through"
              else "none"
              end
            )
          }
        ),
        button("Remove", onClick: dispatch(:remove))
      ])
    end
  end
end


class Slides < Prism::Component
  attr_reader :slides

  def initialize
    @slides = [
      image_slide("title.svg"),
      image_slide('slide1-i-learned-ruby.svg'),
      image_slide('slide2-i-learned-js.svg'),
      image_slide('slide3-i-fell-in-love-with-the-browser.svg'),
      image_slide('slide4-ruby-advantages.svg'),
      image_slide('slide4-what-if-we-could-use-ruby.svg'),
      image_slide('slide6-problem1.svg'),
      image_slide('slide7-emscripten.svg'),
      image_slide('slide8-problem2.svg'),
      image_slide('slide9-matz-to-the-rescue.svg'),
      image_slide('slide10-problem3.svg'),
      image_slide('slide11-a-wild-webassembly-appears.svg'),
      image_slide('slide12-what-a-browser-do.svg'),
      image_slide('slide13-parse-optimize-generate.svg'),
      image_slide('slide14-what-if-we-could-just.svg'),
      image_slide('slide15-now-youre-cooking.svg'),
      image_slide('slide16-only-one-problem-left.svg'),
      image_slide('slide17-what-good-is-an-app-that-only-logs.svg'),
      image_slide('slide19-the-same-again-but-better.svg'),
      image_slide('slide20-presenting-prism.svg'),
      image_slide('slide21-enough-talk-lets-dance.svg'),
      HelloRubyDrawnSlide.new,
      image_slide('slide23-demo-time.svg'),
      image_slide('slide24-yay.svg'),
      image_slide('slide25-yak-shaving.svg'),
      image_slide('slide26-but-what-about.svg'),
      image_slide('slide27-we-did-it.svg'),
      image_slide('slide28-thanks.svg'),
      TodoListSlide.new,
      HangmanSlide.new,
    ]

    @index = 0

    DOM.select('document').on('keydown') do |event|
      keydown(event["key"])
    end
  end

  def slide(content)
    div(".slide", [h2("", content)])
  end

  def image_slide(src)
    div(".slide", [img(props: {src: "assets/#{src}"})])
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
    div(".slides", {click: dispatch(:next_slide), onKeydown: dispatchEvent(:keydown), attrs: {tabIndex: 0}}, [
      img(
        ".control",
        onClick: dispatch(:previous_slide),
        props: {src: "assets/prev.svg"},
        class: {hidden: first_slide?}
      ),
      current_slide,
      img(
        ".control",
        onClick: dispatch(:next_slide),
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
