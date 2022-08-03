class JSBindingsTest
  include JS::Global

  def initialize
    @results = []
    @tests = []
  end

  def run
    puts " "

    tests
    run_tests
  end

  def report_results
    passes = @results.select { |result| result[:passed] }
    failures = @results.reject { |result| result[:passed] }

    puts " "
    puts "Finished: #{passes.length}/#{@results.length} passed"
    puts "Exit code: #{failures.length > 0 ? 1 : 0}"
  end

  def report_success(test)
    @results << result = {name: test[:name], passed: true}
    puts " ✔ passed - #{test[:name]}"
  end

  def report_error(test, error)
    @results << result = {name: test[:name], passed: false, error: error}
    puts " ✖ failed! - #{test[:name]}"
    puts " "
    puts result[:error].inspect
    result[:error].backtrace.each do |line|
      puts "  " + line
    end
    puts " "
  end

  def run_test_async(test)
    begin
      timeoutId = window.setTimeout(-> {
        begin
          raise StandardError.new("Timeout error!")
        rescue StandardError => e
          report_error(test, e)
        end
      }, 1000)

      test[:block].call ->*args do
        if args.length > 1
          report_error(test, args.first)
        else
          report_success(test)
          window.clearTimeout(timeoutId)
        end

        window.setTimeout(method(:run_tests))
      end
    rescue Exception => e
      report_error(test, e)
    end
  end

  def run_test_sync(test)
    begin
      test[:block].call
      report_success(test)
    rescue Exception => e
      report_error(test, e)
    end

    window.setTimeout(method(:run_tests))
  end

  def run_tests
    return report_results if @tests.empty?

    test = @tests.shift

    async = test[:async]

    if async
      run_test_async(test)
    else
      run_test_sync(test)
    end
  end

  def run_test(name, &block)
    @tests << {name: name, block: block, async: block.arity == 1}
  end

  def _run_test(name, &block)
    begin
      block.call
    rescue Exception => e
    else
    end
  end

  def assert(condition)
    fail "Assertion error" unless condition
  end

  def assert!(condition)
    assert(!condition)
  end

  def assert_eq(a, b)
    fail "Assertion error: Expected `#{a.inspect}` to eq `#{b.inspect}`" unless a == b
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

    run_test "setting a property to nil" do
      div1 = document.createElement('div')

      div1.prop = nil

      assert_eq(div1.prop, nil)
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

    run_test "calling a method that returns null" do
      regexp = window.RegExp!.new("test")
      assert_eq(regexp.exec('foo'), nil)
    end

    run_test "passing an array of numbers to a JS method" do
      window.eval("window.getFirst = function(arr) {return arr[0]}")

      assert_eq(window.getFirst([1, 2, 3]), 1)
      assert_eq(window.getFirst([1, 2, 3]), 1)
    end

    run_test "passing an array of strings to a JS method" do
      window.eval("window.getFirst = function(arr) {return arr[0]}")

      assert_eq(window.getFirst(['a', 'b', 'c']), 'a')
    end

    run_test "passing nil values to JS" do
      window.eval("window.valueIsNull = function(v) {return v === null}")

      assert_eq(window.valueIsNull(nil), true)
    end

    run_test "passing nil values in an array to JS" do
      window.eval("window.getFirst = function(arr) {return arr[0]}")

      assert_eq(window.getFirst([nil, 'b', 'c']), nil)
    end

    run_test "passing an iterable to JS" do
      window.eval <<~JS
        window.sum = function (arr) {
          let total = 0;

          for (let i of arr) {
            total += i;
          }

          return total;
        }
      JS

      assert_eq(window.sum([1, 2, 3]), 6)
    end

    run_test "passing a hash to JS" do
      window.eval <<~JS
        window.getFoo = function (obj) {
          return obj.foo;
        }
      JS

      assert_eq(window.getFoo({"foo" => 5}), 5)
    end

    run_test "passing an array of JS items to JS" do
      window.eval <<~JS
        window.firstItemIsPromise = function (array) {
          return array[0] instanceof Promise;
        }
      JS

      promise = window.Promise!.new do |resolve, reject|
        resolve.call
      end

      assert_eq(window.firstItemIsPromise([promise]), true)
    end

    run_test "passing an array of promises to JS" do |done|
      makePromise = -> do
        result = nil

        promise = window.Promise!.new do |resolve, reject|
          result = resolve
        end

        [promise, result]
      end

      promiseA, resolveA = makePromise.call
      promiseB, resolveB = makePromise.call
      resolved = false

      allPromise = window.Promise!.all([
        promiseA,
        promiseB
      ])

      allPromise.then do
        fail "out of order resolution" unless resolved
        done.call
      end

      resolveA.call
      resolved = true
      resolveB.call
    end

    run_test "accessing a missing property on a ruby value from JS" do
      window.eval <<~JS
        window.getFoo = function (obj) {
          return obj.foo;
        }
      JS

      data = {}

      assert_eq(window.getFoo(data), undefined)
    end

    run_test "accessing an out of bounds property on a ruby array from JS" do
      window.eval <<~JS
        window.getThird = function (obj) {
          return obj[2];
        }
      JS

      data = []

      assert_eq(window.getThird(data), undefined)
    end

    run_test "JS setting a property on a ruby object" do
      window.eval <<~JS
        window.setFoo = function (obj) {
          obj.foo = "bar"
        }
      JS

      data = {}

      window.setFoo(data)

      assert_eq(data["foo"], "bar")
    end

    run_test "JS setting a property on a ruby array" do
      window.eval <<~JS
        window.setFirst = function (obj, val) {
          obj[0] = "bar"
        }
      JS

      data = []

      window.setFirst(data)

      assert_eq(data[0], "bar")
    end

    run_test "ruby objects have a typeof object" do
      window.eval <<~JS
        window.typeOf = function (obj) {
          return typeof obj;
        }
      JS

      assert_eq(window.typeOf({}), "object")
    end

    run_test "ruby procs have a typeof function" do
      window.eval <<~JS
        window.typeOf = function (obj) {
          return typeof obj;
        }
      JS

      assert_eq(window.typeOf(-> {}), "function")
    end

    run_test "ruby arrays are recognized by Array.isArray" do
      assert_eq(window.Array!.isArray([]), true)
    end

    run_test "ruby arrays have a length property in JS" do
      window.eval <<~JS
        window.assertLengthIsThree = function (obj) {
          return obj.length === 3;
        }
      JS

      assert_eq(window.assertLengthIsThree([:a, :b, :c]), true)
      assert_eq(window.assertLengthIsThree([]), false)
    end

    run_test "ruby hashes can be used with for-in" do
      window.eval <<~JS
        window.forInTest = function (obj) {
          var output = "";

          for (var key in obj) {
            output += key;
            output += obj[key];
          }

          return output;
        }
      JS

      assert_eq(window.forInTest({"foo" => "bar"}), "foobar")
    end

    run_test "ruby strings are converted to JavaScript" do
      input = {"test" => -> { "result" }}

      window.eval <<~JS
        window.stringConversionTest = function (obj) {
          return obj.test() === "result";
        }
      JS

      assert_eq(window.stringConversionTest(input), true)
    end

    run_test "ruby numbers are converted to JavaScript" do
      input = {"test" => -> { 5 }}

      window.eval <<~JS
        window.numberConversionTest = function (obj) {
          return obj.test() === 5;
        }
      JS

      assert_eq(window.numberConversionTest(input), true)
    end

    run_test "ruby class method is not exposed to JS" do
      input = {"class" => "foo"}

      window.eval <<~JS
        window.classExposureTest = function (obj) {
          return obj.class == "foo";
        }
      JS

      assert_eq(window.classExposureTest(input), true)
    end

    run_test "symbol keys can be looked up with strings in JS" do
      input = {arbitrary: "data"}

      window.eval <<~JS
        window.symbolKeyLookupTest = function (obj) {
          return obj.arbitrary == "data";
        }
      JS

      assert_eq(window.symbolKeyLookupTest(input), true)
    end
  end
end

JSBindingsTest.new.run
