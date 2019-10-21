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

      if instance.respond_to? message["type"]
        instance.send(message["type"], *message["args"])
      else
        raise "Component #{instance.class} has no method ##{message["type"]}"
      end
    end
  end

  class Document
  end

  class Component
    TAG_NAMES = [
    'a',
    'abbr',
    'address',
    'area',
    'article',
    'aside',
    'audio',
    'b',
    'base',
    'bdi',
    'bdo',
    'blockquote',
    'body',
    'br',
    'button',
    'canvas',
    'caption',
    'cite',
    'code',
    'col',
    'colgroup',
    'dd',
    'del',
    'details',
    'dfn',
    'dir',
    'div',
    'dl',
    'dt',
    'em',
    'embed',
    'fieldset',
    'figcaption',
    'figure',
    'footer',
    'form',
    'h1',
    'h2',
    'h3',
    'h4',
    'h5',
    'h6',
    'head',
    'header',
    'hgroup',
    'hr',
    'html',
    'i',
    'iframe',
    'img',
    'input',
    'ins',
    'kbd',
    'keygen',
    'label',
    'legend',
    'li',
    'link',
    'main',
    'map',
    'mark',
    'menu',
    'meta',
    'nav',
    'noscript',
    'object',
    'ol',
    'optgroup',
    'option',
    'p',
    'param',
    'pre',
    'progress',
    'q',
    'rp',
    'rt',
    'ruby',
    's',
    'samp',
    'script',
    'section',
    'select',
    'small',
    'source',
    'span',
    'strong',
    'style',
    'sub',
    'summary',
    'sup',
    'table',
    'tbody',
    'td',
    'textarea',
    'tfoot',
    'th',
    'thead',
    'time',
    'title',
    'tr',
    'u',
    'ul',
    'video',
    ]

    TAG_NAMES.each do |tag|
      define_method(tag.to_sym) do |*args|
        options = {}
        className = ""
        children = []

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

        options[:type] = tag
        options[:class] = className
        options[:children] = children || []

        options[:children] = options[:children].compact.map do |child|
          if child.is_a?(Prism::Component)
            child.render
          elsif child.is_a?(String)
            text(child)
          else
            child
          end
        end

        options
      end
    end

    def text(t)
      {:type => "text", :content => t.to_s}
    end

    def dispatch(sym, *args)
      Prism.instances[object_id] = self # TODO - this is a memory leak
      {:instance => object_id, :type => sym, :args => args, includeEvent: false}
    end

    def dispatchEvent(sym, *args)
      Prism.instances[object_id] = self # TODO - this is a memory leak
      {:instance => object_id, :type => sym, :args => args, includeEvent: true}
    end

    def dispatchWith(prop, sym, *args)
      Prism.instances[object_id] = self # TODO - this is a memory leak
      {:instance => object_id, :type => sym, :args => args, includeProp: prop}
    end

    def render
      raise "Unimplemented render method for #{self.class.name}"
    end
  end
end
