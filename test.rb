module Prism
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

  def dispatch(sym)
    {:type => "dispatch", :value => sym}
  end

  def mount(message)
    update(message.to_sym)

    {:state => @props, :dom => render}
  end
end

class Counter
  include Prism

  def initialize(props)
    @props = props
  end

  def update(message)
    case message
    when :increase
      @props["count"] += 1
    when :decrease
      @props["count"] -= 1
    end
  end

  def count
    @props["count"]
  end

  def render
    div({:class => "counter"}, [
      div([text(count)]),
      button({:onClick => dispatch(:increase)}, [text("+")]),
      button({:onClick => dispatch(:decrease)}, [text("-")])
    ])
  end
end

raw_props = ARGV[1] || '{"count": 0}'
message = ARGV[2] || :noop
props = JSON.parse(raw_props)

puts JSON.generate(Counter.new(props).mount(message))
