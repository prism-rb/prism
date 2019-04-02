module Prism
  def self.mount(component, props)
    if ARGV[1]
      props = JSON.parse(ARGV[1])
    end
    message = ARGV[2] || '{"message": "noop", "args": []}'
    message = JSON.parse(message)
    puts JSON.generate(component.new(props).mount(message))
  end
end

class Prism::Component
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

  def initialize(props)
    @props = props
  end

  TAG_NAMES.each do |tag|
    define_method(tag.to_sym) do |*args|
      options, children = *args

      if options.is_a? Array
        children = options
        options = {}
      end

      options = options || {}
      options[:type] = tag
      options[:_children] = children || []

      options
    end
  end

  def text(t)
    {:type => "text", :content => t.to_s}
  end

  def dispatch(sym, *args)
    {:type => "dispatch", :value => sym, :args => args}
  end

  def mount(message)
    m = message["message"].to_sym

    send(m, *message["args"]) unless m == :noop

    {:state => @props, :dom => render}
  end
end


class Counter < Prism::Component
  def count
    @props["count"]
  end

  def change(amount)
    @props["count"] += amount
  end

  def reset
    @props["count"] = 0
  end

  def render
    div({:class => "counter"}, [
      div([text(count)]),
      button({:onClick => dispatch(:change, 1)}, [text("+")]),
      button({:onClick => dispatch(:change, -1)}, [text("-")]),
      button({:onClick => dispatch(:reset)}, [text("Reset")])
    ])
  end
end

Prism.mount(Counter, {"count" => 0})
