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

  def assert!(condition)
    assert(!condition)
  end

  def assert_eq(a, b)
    fail "Assertion error: Expected `#{a}` to eq `#{b}`" unless a == b
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

    run_test "setting a boolean property" do
      div = document.createElement('div')

      div.foo = false

      assert div.foo == false
    end

    run_test "setting an object property" do
      div = document.createElement('div')

      foo = Struct.new(:bar).new(5)

      div.foo = foo

      assert_eq(div.foo.bar, 5)
    end

    run_test "setting a proc property" do
      proc_called = false

      window.foo = Proc.new do
        proc_called = true
      end

      window.foo.call

      assert_eq(proc_called, true)
    end

    run_test "setting a property to a JS::Value" do
      div1 = document.createElement('div')
      div2 = document.createElement('div')

      div2.prop = "hello"

      div1.el = div2

      assert div1.el.prop == "hello"
    end

    run_test "setting a property to JS::Undefined" do
      window.prop = undefined

      assert_eq(window.eval("String(window.prop)"), "undefined")
    end

    run_test "setting and getting a falsy value" do
      window.prop = 0

      assert_eq(window.prop, 0)

      window.prop = false

      assert_eq(window.prop, false)
    end

    run_test "setting a property to a hash" do
      div = document.createElement('div')

      div.obj = {"a" => "hello"}

      assert_eq(div.obj["a"], "hello")
    end

    run_test "setting a property to an array" do
      div = document.createElement('div')

      div.obj = [1, 2, 3]

      assert_eq(div.obj.last, 3)
    end

    run_test "getting a string property" do
      assert(document.querySelector('body').innerText.is_a?(String))
    end

    run_test "getting a numeric property" do
      assert(window.innerWidth.is_a?(Float))
    end

    run_test "making a set" do
      set = window.Set!.new

      set.add 5

      assert(set.has 5)
      assert!(set.has 6)
    end
  end
end

Prism.mount(JSBindingsTest.new() {})
