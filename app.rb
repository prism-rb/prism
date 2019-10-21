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

class Slides < Prism::Component
  attr_reader :slides

  def initialize
    @slides = [
      TitleSlide.new,
      slide("A tale of two languages"),
      slide("I love the browser"),
      slide("Let's write Ruby in the browser!"),
      slide("The world isn't ready"),
      slide("Suddenly, WebAssembly!"),
      slide("The world still isn't ready!"),
      slide("Matz to the rescue"),
      slide("Putting all the pieces together"),
      slide("Ruby, meet the browser"),
      slide("Presenting: Prism"),
      CounterListSlide.new,
      HangmanSlide.new
    ]

    @index = 0
  end

  def slide(content)
    div(".slide", [h2("", content)])
  end

  def previous
    @index -= 1 unless first_slide?
  end

  def next
    @index += 1 unless last_slide?
  end

  def keydown(event)
    puts event
  end

  def render
    div(".slides", {onKeydown: dispatchEvent(:keydown)}, [
      current_slide,
      div(".controls", [
        button(
          "Previous",
          onClick: dispatch(:previous),
          props: {disabled: first_slide?}
        ),
        button(
          "Next",
          onClick: dispatch(:next),
          props: {disabled: last_slide?}
        )
      ])
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
