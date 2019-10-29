
## Prism

Build React-style web apps with Ruby and WebAssembly 

### Introduction

Prism is a tool that uses [mruby](https://github.com/mruby/mruby) and [emscripten](https://emscripten.org/) to compile ruby code to WebAssembly. It also provides a runtime layer for working with the DOM and events, so you can use it make SPAs.

⚡️ Prism is currently in extremely early alpha. Expect bugs, breaking API changes, missing functionality and rough edges. ⚡️

### Getting started

Prism requires that you have both [mruby](https://github.com/mruby/mruby) and [emscripten](https://emscripten.org/) installed and available on your path.

You can install mruby through your preferred package manager, such as homebrew, apt-get or nix.

Package managers often have outdated versions of emscripten, so it's recommended that you install via `emsdk`. Instructions are available on the [emscripten website](https://emscripten.org/docs/getting_started/downloads.html).

You can install Prism using `gem install prism-cli`.

### CLI Usage

You can initialize a new Prism app by running `prism init`. This simply creates a hello world sample application, by default at `./app.rb` but you can customize the location by providing an argument to `prism init`.

You can then run `prism build` to compile your application. You can provide an entrypoint, but `./app.rb` is assumed by default.

`prism build` creates a sample html file, a bundle for Prism's runtime JS code, the emscripten runtime code and the ruby compiled to Wasm.

To test your application, you can run `prism server` and open `localhost:3042` in your browser. You should see a hello world application with an input and some text. You should be able to change the input and see the text change.

### Writing a Prism App

Prism apps are written in mruby. mruby is a lightweight implementation of Ruby that's suitable for compiling to the web.

mruby is similar in many ways to cruby and will be a familiar experience for someone who has only used the mainline interpreter. The most notable exception is that mruby only supports syntax up to ruby 1.9, which means there are no keyword arguments or safe traversal operator.

There are a number of other small differences, and it's worth reviewing the [mruby limitations documentation](https://github.com/mruby/mruby/blob/master/doc/limitations.md).

If you run `prism init`, it will create a sample application that makes a good starting point. This is the code it outputs:

```ruby
class HelloWorld < Prism::Component
  attr_accessor :name

  def initialize(name = "World")
    @name = name
  end

  def render
    div(".hello-world", [
      input(onInput: call(:name=).with_target_data(:value)),
      div("Hello, #{name}")
    ])
  end
end

Prism.mount(HelloWorld.new)
```

Let's break this down piece by piece.

----------

```ruby
class HelloWorld < Prism::Component
```

Much like Rails, Prism provides most of it's functionality through base classes that you should inherit from.

The key concept in Prism is a Component, which should be familiar to anyone who has worked with JS frameworks like React, Vue or similar.

`Prism::Component` provides helper methods for creating virtual dom elements, and for handling events.

----------

```ruby
  attr_accessor :name

  def initialize(name = "World")
    @name = name
  end
```

This is fairly standard Ruby, and there's nothing actually unique to Prism or mruby going on. Note that we're defining an `attr_accessor` rather than just an `attr_reader`, so that we can set the name directly when it changes.

----------

```ruby
  def render
    div(".hello-world", [
      input(onInput: call(:name=).with_target_data(:value)),
      div("Hello, #{name}")
    ])
  end
```

It's expected that Prism components implement a `#render` method that returns a representation of what the current view should be.

This should be familiar to anyone who has worked with React, Cycle.js or Elm. There is a method defined for each different dom element. You can provide a class name or id as a string (`".todo-list-item"` or `"#login"`), an object with options to configure the attributes, props, styles, classes and event listeners, and an array of child elements.

Prism's virtual dom is powered by `snabddom`, a tried and true lightweight JavaScript vdom library. For the most part, the API is simply passed through to snabbdom, so it's worth reading the [snabddom docs](https://github.com/mruby/mruby/blob/master/doc/limitations.md).

----------

```ruby
  input(onInput: call(:name=).with_target_data(:value)),
```

The most interesting line in this example is the event handler for the `input` event.

`Prism::Component` defines a `#call` method that you can use to call methods on your component when events occur.

`#call` takes a symbol that is the method name to call, and any arguments you want passed to the method.

You can also include data from the event or target element using `.with_event_data` and `.with_target_data`. These methods can be chained as needed.

----------

```ruby
Prism.mount(HelloWorld.new)
```

The last line mounts the HelloWorld component. Prism is currently hardcoded to mount to an element with id `#root` on load. In future this will be configurable.


### API

#### **`Prism::Component`**

##### `#div(identifier, options, children), #img, #p, ...`

Helpers for creating virtual dom elements. There is a method for every type DOM element.

The arguments are all optional and can be provided in any order for convenience.

Arguments:

  - `identifier` *string, optional* - A shorthand for setting the id and classes. E.g. `"#login"`, `.alert`, `#header.flex.dark`

  - `options` *object, optional* - Element configuration

    - `attrs` *object, optional* - Attributes that are set when the element is created. Equivalent to putting items directly into the element in the HTML.
    - `props` *object, optional* - Props to be set on the object.
    - `style` *object, optional* - Element styles, keys are css properties and values are strings.
    - `class` *object, optional* - Keys are class names, values are booleans indicating whether or not the class is active. An easy way to add or remove classes based on a condition.
    - `on` *function, optional* - Keys are browser events (like `click` or `input`), values are `Prism::EventHandler` instances. See below on how to create `EventHandler` instances.  Additionally, there are a number of aliases that let you set event handlers directly on the `options` object. The full list that is currently aliased is: `onClick`, `onChange`, `onInput`, `onMousedown`, `onMouseup`, `onKeydown`, `onKeyup` and `onScroll`

  - `children` *array or string, optional* - Either a string of content for the element or an array of children. Each child should either be a string, a virtual dom tree, or an instance of a `Prism::Component` with `#render`.


##### `#call(method_name, *arguments)`

Arguments:
  
  - `method_name` *symbol* - The name of the method to call when the event occurs. Returns a `Prism::EventHandler`.
  - `*arguments` *any, variadic* - You can provide arguments that will be passed to the method after the method name. Please note any argument currently needs to be serializable, this will change in future.

##### `#prevent_default`

Takes no arguments, returns a `Prism::EventHandler` that does nothing but call `event.preventDefault()`.

##### `#stop_propagation`

Takes no arguments, returns a `Prism::EventHandler` that does nothing but call `event.stopPropagation()`.

---------

#### **`Prism::EventHandler`**

Represents a handler for an event, with a method to call and arguments to pass. The arguments are a mixture of values passed from Ruby and values pulled from the event and targed in JS. The order of arguments is based on how the event handler was constructed.

##### `#with_args(*args)`

Adds arguments to an existing event handler.

#### `#with_event`

Add an event argument to the handler. When the method is called, a serialized version of the event will be passed.

#### `#with_event_data(*properties)`

Add arguments that contain data from the event. The properties should be either a string or a symbol. One property you might want to extract from the event is `:key` for `keydown` events.

#### `#with_target_data(*properties)`

Add arguments that contain data from the target element. The properties should be either a string or a symbol. You could for example extract the `:value` of an `input` or the `:checked` field of a tickbox.

#### `#prevent_default`

Calls `.preventDefault()` on the event when it occurs.

#### `#stop_propagation`

Calls `.stopPropagation()` on the event when it occurs.

#### Examples:

`call(:name=).with_target_data(:value)` - calls a setter with the content of the target element
`call(:goto_page, 5).with_event` - calls a method with the number 5 as the first argument and the event data as the second


### Future

As mentioned above, Prism is still in extremely early development. The following would be nice to have but has yet to be implemented.

 - support for require
 - transpile modern ruby syntax to 1.9
 - a way for users to make their own IO drivers
 - built in support for HTTP
 - compile time improvements
 - fallback to asm.js for old browsers
 - rails integration
 - SSR
 - sourcemaps for mruby code
 - linting for incompatibilities with cruby
 - elm-reactor style dev server

If you're interested in helping implement any of those features, or you want to contribute in any way, please make an issue or a pull request or just [get in touch with me](mailto:ncwjohnston@gmail.com).

Prism is currently developed by a single person (who also has a lot of other ambitious projects). I would love to have some other people to help share the load. There's lots of low hanging fruit still to be plucked.

### License

Prism is available under the MIT license. Please see the LICENSE file for more details.
