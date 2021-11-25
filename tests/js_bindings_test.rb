class JSBindingsTest < Prism::Component
  include JS::Global

  def initialize
    @results = []

    puts ""

    tests

    passes = @results.select { |result| result[:passed] }
    failures = @results.reject { |result| result[:passed] }

    puts "Finished: #{passes.length}/#{@results.length} passed"
    puts "Exit code: #{failures.length > 0 ? 1 : 0}"
  end

  def run_test(name)
    begin
      puts name
      yield
    rescue Exception => e
      @results << result = {name: name, passed: false, error: e}
      puts " ✖ Failed"
      puts ""
      puts result[:error].inspect
      result[:error].backtrace.each do |line|
        puts "  " + line
      end
      puts ""
    else
      @results << result = {name: name, passed: true}
      puts " ✔ Passed"
      puts ""
    end
  end

  def assert(condition)
    fail "Assertion error" unless condition
  end

  def assert_eq(a, b)
    fail "Assertion error: Expected #{a} to eq #{b}" unless a == b
  end

  def render
    div("", {}, [ ])
  end

  def tests
    run_test "window is accessible" do
      assert window.is_a?(JS::Value)
    end

    run_test "document is accessible" do
      assert document.is_a?(JS::Value)
    end

    run_test "creating an element" do
      div = document.createElement('div')

      document.body.appendChild(div)
    end

    run_test "changing styles" do
      div = document.createElement('div')

      div.style.background = 'red'

      document.body.appendChild(div)
    end

    run_test "setting a numeric property" do
      div = document.createElement('div')

      div.foo = 50

      assert div.foo == 50
    end

    run_test "setting a string property" do
      div = document.createElement('div')

      div.foo = "bar"

      assert div.foo == "bar"
    end

    run_test "setting a property to a JS::Value" do
      div1 = document.createElement('div')
      div2 = document.createElement('div')

      div2.prop = "hello"

      div1.el = div2

      assert div1.el.prop == "hello"
    end

    run_test "setting a property to a hash" do
      div = document.createElement('div')

      div.obj = {"a" => "hello"}

      assert_eq(div.obj["a"], "hello")
    end

    run_test "making a set" do
      set = window.Set.new

      window.foo = Hash.new
    end
  end
end

Prism.mount(JSBindingsTest.new() {})
