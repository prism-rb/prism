module Prism
  @@instances = {}

  def self.instances
    @@instances
  end

  def self.mount(component)
    Mount.new(component)
  end

  class Mount
    def initialize(component)
      @component = component
    end

    def render
      JSON::stringify(@component.render)
    end

    def dispatch(messageJSON)
      message = JSON::parse(messageJSON)

      instance = Prism.instances[message["instance"]]

      instance.process(message)
    end

    def event(eventJSON, id)
      DOM.event(JSON::parse(eventJSON), id)
    end

    def http_response(responseJSON, id)
      HTTP._response(HTTP::Response.from_json(responseJSON), id)
    end
  end

  class Component
    TAG_NAMES = %i[
      a
      abbr
      address
      area
      article
      aside
      audio
      b
      base
      bdi
      bdo
      blockquote
      body
      br
      button
      canvas
      caption
      cite
      code
      col
      colgroup
      dd
      del
      details
      dfn
      dir
      div
      dl
      dt
      em
      embed
      fieldset
      figcaption
      figure
      footer
      form
      h1
      h2
      h3
      h4
      h5
      h6
      head
      header
      hgroup
      hr
      html
      i
      iframe
      img
      input
      ins
      kbd
      keygen
      label
      legend
      li
      link
      main
      map
      mark
      menu
      meta
      nav
      noscript
      object
      ol
      optgroup
      option
      p
      param
      pre
      progress
      q
      rp
      rt
      ruby
      s
      samp
      script
      section
      select
      small
      source
      span
      strong
      style
      sub
      summary
      sup
      table
      tbody
      td
      textarea
      tfoot
      th
      thead
      time
      title
      tr
      u
      ul
      video
    ]

    TAG_NAMES.each do |tag|
      define_method(tag) do |*args|
        options = {}
        className = ""
        children = []

        result = {}

        until args.empty?
          arg = args.shift

          case arg
          when String
            if arg.start_with?(".")
              className = arg
            else
              children = [text(arg)]
            end
          when Array
            children = arg
          when Object
            options = arg
          end
        end

        options.each do |key, value|
          next if value.is_a?(EventHandler) || (key.to_s).chars.first == '_'
          result[key] = value
        end

        result[:_type] = tag
        result[:_class] = className
        options[:_children] = children || []

        result[:_children] = options[:_children].compact.map do |child|
          if child.is_a?(Prism::Component)
            child.render
          elsif child.is_a?(String)
            text(child)
          else
            child
          end
        end

        result[:on] ||= {}

        options.each do |key, value|
          key_as_string = key.to_s
          next unless key_as_string.start_with?('on')
          event_name = key_as_string.sub('on', '').downcase
          result[:on][event_name] = _register_handler(value)
        end

        if options[:on]
          event_handlers = {}

          options[:on].each do |key, value|
            event_handlers[key] = value.to_hash
          end

          result[:on] = event_handlers
        end

        result
      end
    end

    def text(t)
      {:type => "text", :content => t.to_s}
    end

    def call(method_name, *args)
      EventHandler.new(self, method_name).with(*args)
    end

    def stop_propagation
      EventHandler.new(self, method_name).stop_propagation
    end

    def prevent_default
      EventHandler.new(self, method_name).prevent_default
    end

    def _register_handler(handler)
      Prism.instances[handler.id] = handler # TODO - this is a memory leak
      handler.to_hash
    end

    def render
      raise "Unimplemented render method for #{self.class.name}"
    end
  end

  class EventHandler
    attr_reader :method_name, :id

    def initialize(instance, method_name, args = [], options = {})
      @instance = instance
      @id = self.object_id
      @method_name = method_name
      @args = args
      @options = {prevent_default: false, stop_propagation: false}.merge(options)
    end

    def with(*additionalArgs)
      new_args = additionalArgs.map { |a| {type: :constant, value: a} }

      EventHandler.new(@instance, method_name, @args + new_args, @options)
    end

    def with_event
      EventHandler.new(@instance, method_name, @args + [{type: :event}], @options)
    end

    def with_event_data(*property_names)
      new_args = property_names.map { |item| {type: :event_data, key: item } }

      EventHandler.new(@instance, method_name, @args + new_args, @options)
    end

    def with_target_data(*items)
      target_args = items.map { |item| {type: :target_data, key: item } }
      EventHandler.new(@instance, method_name, @args + target_args, @options)
    end

    def prevent_default
      EventHandler.new(@instance, method_name, @args, @options.merge(prevent_default: true))
    end

    def stop_propagation
      EventHandler.new(@instance, method_name, @args, @options.merge(stop_propagation: true))
    end

    def process(message)
      call_args = []
      message_args = message["args"]

      @args.each do |arg|
        case arg[:type]
        when :constant
          call_args << arg[:value]
        else
          call_args << message_args.shift
        end
      end

      if @instance.respond_to? message["type"]
        @instance.send(message["type"], *call_args)
      else
        raise "Component #{@instance.class} has no method ##{message["type"]}"
      end
    end

    def to_hash
      {
        instance: @id,
        type: @method_name,
        args: @args,
        prevent_default: @options[:prevent_default],
        stop_propagation: @options[:stop_propagation]
      }
    end
  end
end

module DOM
  @@event_id = 0
  @@listeners = {}

  def self.get_event_id
    @@event_id += 1

    @@event_id.to_s
  end

  def self.add_listener(id, &block)
    @@listeners[id] = block
  end

  def self.select(selector)
    ElementSelection.new(selector)
  end

  def self.event(eventData, id)
    @@listeners[id].call(eventData)
  end

  class ElementSelection
    def initialize(selector)
      @selector = selector
    end

    def on(eventName, &block)
      id = DOM.get_event_id
      InternalDOM.add_event_listener(@selector, eventName, id)
      DOM.add_listener(id, &block)
    end
  end
end

module HTTP
  @@event_id = 0
  @@listeners = {}

  def self.get_event_id
    @@event_id += 1

    @@event_id.to_s
  end

  def self.add_listener(id, &block)
    @@listeners[id] = block
  end

  def self.get(url, &block)
    id = HTTP.get_event_id

    InternalHTTP.http_request(url, id)

    HTTP.add_listener(id, &block)
  end

  def self._response(text, id)
    @@listeners[id].call(text)
  end

  class Response < Struct.new(:body)
    def self.from_json(json)
      data = JSON::parse(json)

      new(data["body"])
    end
  end
end

class Prism::ExternalReferences
  @@reference_id = 0
  @@references = {}


  def self.get_reference(descriptor_and_callable)
    id = @@reference_id

    @@references[id] = descriptor_and_callable

    @@reference_id += 1

    id
  end

  def self.handle_callback(reference)
    args = []

    descriptor_and_callable = @@references[reference]

    descriptor_and_callable[:descriptor][:options][:args].each_with_index do |arg_description, i|
      if arg_description[:type] == "DOMString"
        args.push(InternalBindings.get_arg_string(i))
        next
      end

      if arg_description[:type] == "DOMHighResTimeStamp"
        args.push(InternalBindings.get_arg_number(i))
        next
      end

      _js_class = InternalBindings.get_arg_class_name(i)
      _js_class = nil if _js_class == ""

      _class = JS.const_get(_js_class || arg_description[:type])

      if _class
        arg_reference = InternalBindings.get_arg_reference(i)

        if arg_reference
          args.push(_class.new(arg_reference))
        else
          args.push(nil)
        end
      end
    end

    callable = descriptor_and_callable[:callable]

    callable.call(*args.slice(0...callable.parameters.size))
  end

  def self.cleanup_reference(reference)
    puts "Delete reference -> #{reference}"
    @@references.delete(reference)
  end
end

module Prism::BindingHelpers
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    private def bind_attr_reader(name, options)
      self.define_method(name) do |*args|
        begin
          _class = JS.const_get(options[:return_type])
        rescue NameError => e
          _class = nil
        end

        if _class
          reference = InternalBindings.get_value_reference(@js_value, name.to_s)

          if reference == 0
            nil
          else
            _class.new(reference)
          end
        else
          InternalBindings.get_value_string(@js_value, name.to_s);
        end
      end
    end

    private def bind_attr_accessor(name, options)
      bind_attr_reader(name, options)
      # TODO - attr writer
    end

    private def bind_operation(name, options)
      self.define_method(name) do |*args, &block|
        InternalBindings.clear_args

        args.push(block) if block

        args.zip(options[:args]).each_with_index do |(arg, arg_description), i|
          case arg_description[:type]
          when "DOMString"
            InternalBindings.set_arg_string(i, arg.to_s)
          when "long"
            InternalBindings.set_arg_number(i, arg.to_i)
          else
            _class = JS.const_get(arg_description[:type])

            if _class && _class.is_a?(JS::CallbackInterface)
              reference = Prism::ExternalReferences.get_reference({descriptor: _class, callable: arg})

              InternalBindings.set_arg_callback(i, reference)
            elsif _class && _class.is_a?(JS::TypeDef)
              set = false
              _class.types[:types].each do |type|
                if type === "DOMString" && arg.is_a?(String)
                  InternalBindings.set_arg_string(i, arg)
                  set = true
                  break
                end

                if type == "Function" && arg.respond_to?(:call)
                  reference = Prism::ExternalReferences.get_reference({descriptor: JS::CallbackInterface.new("Function", args: []), callable: arg})

                  InternalBindings.set_arg_callback(i, reference)
                  set = true
                  break
                end
              end

              raise ArgumentError.new("Don't know how to handle arg type: #{_class} #{arg}") unless set
            else
              raise ArgumentError.new("Don't know how to handle arg type: #{arg_description[:type]}")
            end
          end
        end

        begin
          _class = JS.const_get(options[:return_type])
        rescue NameError => e
          _class = nil
        end

        if _class
          reference = InternalBindings.call_method_reference(@js_value, name.to_s)

          if reference == 0
            nil
          else
            _class.new(reference)
          end
        else
          InternalBindings.call_method(@js_value, name.to_s);
        end
      end
    end
  end
end

module JS
  CallbackInterface = Struct.new(:name, :options)
  TypeDef = Struct.new(:name, :types)

  module Global
    def self.included(base)

      base.define_method(:window) do
        JS::Global.window
      end

      base.define_method(:document) do
        JS::Global.document
      end
    end

    def self.window
      @@window ||= JS::Window.new(InternalBindings.window_reference)
    end

    def self.document
      @@document ||= JS::Document.new(InternalBindings.document_reference)
    end
  end
end

class Prism::Binding
  include Prism::BindingHelpers

  def initialize(js_value)
    @js_value = js_value
  end
end

CONFIG = JSON::parse(JSON_CONFIG)
