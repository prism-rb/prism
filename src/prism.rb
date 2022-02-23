module Kernel
  def async_require(paths, &block)
    JS::Global.window.Prism.require(block, *paths)
  end
end

module Prism
  @@instances = {}

  def self.instances
    @@instances
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

module Prism
  class ExternalReferences
    @@reference_id = 0
    @@references = {}

    def self.get_ruby_reference(value)
      id = @@reference_id

      @@references[id] = value

      @@reference_id += 1

      id
    end


    def self.handle_callback(reference)
      args = []

      callable = dereference(reference)

      arg_count = InternalBindings.get_arg_count

      arg_count.times.with_index do |i|
        ref = InternalBindings.get_arg_reference(i)
        type = InternalBindings.get_type_of(ref.value)
        args << JS::Value.translate_js_value(ref, type)
      end

      callable.call(*args.slice(0...callable.parameters.size))
    end

    def self.cleanup_reference(reference)
      @@references.delete(reference)
    end

    def self.dereference(ruby_reference_id)
      @@references[ruby_reference_id]
    end

    def self.get_ruby_reference_type(prop_name, ruby_reference_id)
      value = @@references[ruby_reference_id]

      prop_name_as_int = prop_name.to_i

      if prop_name_as_int.to_s == prop_name
        prop_name = prop_name_as_int
      end

      case value[prop_name]
      when String
        "string"
      when Numeric
        "number"
      when NilClass
        "null"
      else
        fail "get_ruby_reference_type: #{prop_name} #{value[prop_name]} not handled"
      end
    end

    def self.get_ruby_reference_number(prop_name, ruby_reference_id)
      value = @@references[ruby_reference_id]

      prop_name_as_int = prop_name.to_i

      if prop_name_as_int.to_s == prop_name
        prop_name = prop_name_as_int
      end

      value[prop_name].to_f
    end

    def self.get_ruby_reference_string(prop_name, ruby_reference_id)
      value = @@references[ruby_reference_id]

      prop_name_as_int = prop_name.to_i

      if prop_name_as_int.to_s == prop_name
        prop_name = prop_name_as_int
      end

      value[prop_name].to_s
    end
  end
end

class RubyReference
  def initialize(reference:)
    @reference = reference
  end
end

class InternalBindings
  def self.args_reference
    @args_reference ||= self.get_args_reference
  end
end

module JS
  CallbackInterface = Struct.new(:name, :options)
  TypeDef = Struct.new(:name, :types)

  class Undefined
    def self.singleton
      @@instance ||= Undefined.new
    end
  end

  class Value
    def initialize(reference:)
      fail "bad reference #{reference}" unless reference.is_a?(JSReference)
      @reference = reference
    end

    def new(*args, &block)
      JS::Value.send_args_to_js(*args, &block)

      reference = InternalBindings.call_constructor(@reference.value)

      JS::Value.translate_js_value(reference, InternalBindings.get_type_of(reference.value))
    end

    def _reference
      @reference
    end

    private

    def self.translate_js_value(reference, type)
      return nil if reference.value == 0

      case type
      when "ruby_value"
        ruby_reference_id = InternalBindings.get_ruby_reference_id(reference.value)
        Prism::ExternalReferences.dereference(ruby_reference_id)
      when "object", "function"
        JS::Value.new(reference: reference)
      when "number"
        InternalBindings.get_value_number(reference.value)
      when "string"
        InternalBindings.get_value_string(reference.value)
      when "undefined"
        JS::Undefined
      when "boolean"
        value = InternalBindings.get_value_number(reference.value)

        if value.to_i == 1
          true
        else
          false
        end
      else
        fail "unhandled type #{type}"
      end
    end

    def self.send_args_to_js(*args, &block)
      InternalBindings.clear_args

      args.each_with_index do |arg, index|
        case arg
        when NilClass
          InternalBindings.set_object_null(
            InternalBindings.args_reference.value,
            index.to_s
          )
        when String
          InternalBindings.set_arg_string(index, arg)
        when JS::Value
          InternalBindings.set_arg_value(index, arg._reference.value)
        when Numeric
          InternalBindings.set_arg_number(index, arg)
        when Proc, Method
          arg_reference = Prism::ExternalReferences.get_ruby_reference(arg)

          InternalBindings.set_arg_callback(index, arg_reference)
        else
          ruby_reference_id = Prism::ExternalReferences.get_ruby_reference(arg)
          InternalBindings.set_object_ruby_value(
            InternalBindings.args_reference.value,
            index.to_s,
            ruby_reference_id
          )
        end
      end

      if block
        block_reference = Prism::ExternalReferences.get_ruby_reference(block)

        InternalBindings.set_arg_callback(args.length, block_reference)
      end
    end

    def call_function(reference, *args, &block)
      self.class.send_args_to_js(*args, &block)

      result_reference = InternalBindings.call_method_reference(
        @reference.value,
        reference.value
      )

      self.class.translate_js_value(
        result_reference,
        InternalBindings.get_type_of(result_reference.value)
      )
    end

    def call_setter(name, value)
      case value
      when String
        InternalBindings.set_object_value_string(@reference.value, name, value)
      when Numeric
        InternalBindings.set_object_value_number(@reference.value, name, value)
      when JS::Value
        InternalBindings.set_object_value(@reference.value, name, value._reference.value)
      when JS::Undefined
        InternalBindings.set_object_undefined(@reference.value, name)
      when Proc
        arg_reference = Prism::ExternalReferences.get_ruby_reference(value)

        callback_reference = InternalBindings.make_callback_reference(arg_reference)

        InternalBindings.set_object_value(@reference.value, name, callback_reference.value)
      else
        ruby_reference_id = Prism::ExternalReferences.get_ruby_reference(value)

        InternalBindings.set_object_ruby_value(@reference.value, name, ruby_reference_id)
      end
    end

    def method_missing(name, *args, &block)
      is_constructor = false

      if name.to_s.end_with?("!")
        name = name.to_s[0...-1]
        is_constructor = true
      end

      if name.to_s.end_with?("=") && args.length > 0
        value = args.first

        call_setter(name.to_s[0...-1], value)

        return value
      end

      reference = InternalBindings.get_value_reference(@reference.value, name.to_s)

      return nil if reference.value == 0

      type = InternalBindings.get_type_of(reference.value)

      if type == "function" then
        if is_constructor
          JS::Value.new(reference: reference)
        else
          call_function(reference, *args, &block)
        end
      else
        self.class.translate_js_value(reference, type)
      end
    end
  end

  class Window < Value
    def eval(*args, &block)
      method_missing(:eval, *args, &block)
    end
  end

  module Global
    def self.included(base)
      base.define_method(:window) do
        JS::Global.window
      end

      base.define_method(:document) do
        JS::Global.document
      end

      base.define_method(:undefined) do
        JS::Global.undefined
      end
    end

    def self.window
      @@window ||= JS::Window.new(reference: InternalBindings.window_reference)
    end

    def self.document
      @@document ||= JS::Value.new(reference: InternalBindings.document_reference)
    end

    def self.undefined
      JS::Undefined.singleton
    end
  end
end

CONFIG = JSON::parse(JSON_CONFIG)
