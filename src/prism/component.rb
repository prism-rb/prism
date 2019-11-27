module Prism
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
        result[:on][:click] = options[:onClick].to_hash if options[:onClick]
        result[:on][:change] = options[:onChange].to_hash if options[:onChange]
        result[:on][:input] = options[:onInput].to_hash if options[:onInput]
        result[:on][:mousedown] = options[:onMousedown].to_hash if options[:onMousedown]
        result[:on][:mouseup] = options[:onMouseup].to_hash if options[:onMouseup]
        result[:on][:keydown] = options[:onKeydown].to_hash if options[:onKeydown]
        result[:on][:keyup] = options[:onKeyup].to_hash if options[:onKeyup]
        result[:on][:scroll] = options[:onScroll].to_hash if options[:onScroll]
  
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
      Prism.instances[object_id] = self # TODO - this is a memory leak
      EventHandler.new(object_id, method_name).with(*args)
    end
  
    def stop_propagation
      Prism.instances[object_id] = self # TODO - this is a memory leak
      EventHandler.new(object_id, nil).stop_propagation
    end
  
    def prevent_default
      Prism.instances[object_id] = self # TODO - this is a memory leak
      EventHandler.new(object_id, nil).prevent_default
    end
  
    def render
      raise "Unimplemented render method for #{self.class.name}"
    end
  end
end
