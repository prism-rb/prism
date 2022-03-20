
## Prism

[![Join the chat at https://gitter.im/prism-rb/community](https://badges.gitter.im/prism-rb/community.svg)](https://gitter.im/prism-rb/community?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)
[![Build Status](https://travis-ci.com/prism-rb/prism.svg?branch=master)](https://travis-ci.com/prism-rb/prism)
[![Financial Contributors on Open Collective](https://opencollective.com/prism/all/badge.svg?label=financial+contributors)](https://opencollective.com/prism) [![Join the chat at https://gitter.im/prism-rb/community](https://badges.gitter.im/prism-rb/community.svg)](https://gitter.im/prism-rb/community?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

Build frontend web apps with Ruby and WebAssembly

### Introduction

Prism is a framework that helps you make frontend web applications with Ruby and WebAssembly. It uses [mruby](https://github.com/mruby/mruby) and [emscripten](https://emscripten.org/) to compile ruby code to WebAssembly. It also provides a runtime layer for working with the DOM and events.

⚡️ Prism is currently in extremely early alpha. Expect bugs, breaking API changes, missing functionality and rough edges. ⚡️

### Getting started

You can install Prism from RubyGems using `gem install prism-cli`.

### CLI Usage

You can initialize a new Prism app by running `prism init`. This simply creates a hello world sample application, by default at `./app.rb` but you can customize the location by providing an argument to `prism init`.

You can then run `prism server`, which will start a development server. If you then navigate to `localhost:3042/app.rb`, you should see the sample application. Try changing the code and reloading the page, and the app will update.

If an error occurs, it will be printed out to the browser console.

Building production releases of Prism apps through the command line is still a work in progress.

### Writing a Prism App

Prism apps are written in mruby. mruby is a lightweight implementation of Ruby that's suitable for compiling to the web.

mruby is similar in many ways to cruby and will be a familiar experience for someone who has only used the mainline interpreter.

There are a number of other small differences, and it's worth reviewing the [mruby limitations documentation](https://github.com/mruby/mruby/blob/master/doc/limitations.md). You might also want to refer to the [mruby API docs](http://mruby.org/docs/api/).

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

Much like Rails, Prism provides most of its functionality through base classes that you should inherit from.

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


### Components and State

Prism aims to provide a component system that should feel very similar to most virtual dom based JavaScript frameworks.

You can nest Prism components, and use instances of Prism components directly when rendering in place of dom elements.

Prism has no explicit state management built in, preferring to rely on Ruby's built-in state management tools, primarily instance variables in class instances.

Components in a Prism app persist in memory, and will often have multiple methods call over their lifetime.

Larger Prism applications would likely benefit from adapting a more structured approach to managing certain parts of state, a la Redux.


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

##### `#with_event`

Add an event argument to the handler. When the method is called, a serialized version of the event will be passed.

##### `#with_event_data(*properties)`

Add arguments that contain data from the event. The properties should be either a string or a symbol. One property you might want to extract from the event is `:key` for `keydown` events.

##### `#with_target_data(*properties)`

Add arguments that contain data from the target element. The properties should be either a string or a symbol. You could for example extract the `:value` of an `input` or the `:checked` field of a tickbox.

##### `#prevent_default`

Calls `.preventDefault()` on the event when it occurs.

##### `#stop_propagation`

Calls `.stopPropagation()` on the event when it occurs.

#### Examples:

`call(:name=).with_target_data(:value)` - calls a setter with the content of the target element
`call(:goto_page, 5).with_event` - calls a method with the number 5 as the first argument and the event data as the second

#### `Prism.mount(component)`

Takes an instance of a `Prism::Component` and returns a `Prism::MountPoint`.

The `MountPoint` should be the result of the last expression in the file, as it is used by the Prism C and JS runtime to interact with the application.

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

If you're interested in helping implement any of those features, or you want to contribute in any way, please make an issue or a pull request or just [get in touch with me](mailto:ncwjohnstone@gmail.com).

Prism is currently developed by a single person (who also has a lot of other ambitious projects). I would love to have some other people to help share the load. There's lots of low hanging fruit still to be plucked.

### Supporting Prism Development

Most open source projects are built on a mountain of unpaid labour. Even hugely successful projects that have good funding tend to have a history of excess unpaid labour to get to that point.

Prism is taking a different approach, by launching with an Open Collective page. We're using Open Collective because it enables us to fund Prism as a project rather than one particular person. Funds in the Open Collective will only go towards future development.

If you think this is a worthwhile project, please support us on Open Collective. If you think your company could benefit from Prism in the future, please advocate for your company to financially support Prism.

My main goal around starting Prism with funding is that I want as much of the work that's done on Prism as possible to be reimbursed, no matter who's doing it. The other aspect is that I don't have very much spare time for projects but if I can get paid for my work I can do Prism as part of my day to day contract work.

**[Support Prism on Open Collective](https://opencollective.com/prism)**

## Contributors

### Code Contributors

This project exists thanks to all the people who contribute. [[Contribute](CONTRIBUTING.md)].
<a href="https://github.com/prism-rb/prism/graphs/contributors"><img src="https://opencollective.com/prism/contributors.svg?width=890&button=false" /></a>

### Financial Contributors

Become a financial contributor and help us sustain our community. [[Contribute](https://opencollective.com/prism/contribute)]

#### Individuals

<a href="https://opencollective.com/prism"><img src="https://opencollective.com/prism/individuals.svg?width=890"></a>

#### Organizations

Support this project with your organization. Your logo will show up here with a link to your website. [[Contribute](https://opencollective.com/prism/contribute)]

<a href="https://opencollective.com/prism/organization/0/website"><img src="https://opencollective.com/prism/organization/0/avatar.svg"></a>
<a href="https://opencollective.com/prism/organization/1/website"><img src="https://opencollective.com/prism/organization/1/avatar.svg"></a>
<a href="https://opencollective.com/prism/organization/2/website"><img src="https://opencollective.com/prism/organization/2/avatar.svg"></a>
<a href="https://opencollective.com/prism/organization/3/website"><img src="https://opencollective.com/prism/organization/3/avatar.svg"></a>
<a href="https://opencollective.com/prism/organization/4/website"><img src="https://opencollective.com/prism/organization/4/avatar.svg"></a>
<a href="https://opencollective.com/prism/organization/5/website"><img src="https://opencollective.com/prism/organization/5/avatar.svg"></a>
<a href="https://opencollective.com/prism/organization/6/website"><img src="https://opencollective.com/prism/organization/6/avatar.svg"></a>
<a href="https://opencollective.com/prism/organization/7/website"><img src="https://opencollective.com/prism/organization/7/avatar.svg"></a>
<a href="https://opencollective.com/prism/organization/8/website"><img src="https://opencollective.com/prism/organization/8/avatar.svg"></a>
<a href="https://opencollective.com/prism/organization/9/website"><img src="https://opencollective.com/prism/organization/9/avatar.svg"></a>

### License

Prism is available under the MIT license. Please see the LICENSE file for more details.
