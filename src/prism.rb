class Prism
  def self.mount(component)
    self.new(component)
  end

  def initialize(component)
    @component = component
  end

  def render
    JSON::stringify(@component.render)
  end

  def dispatch(messageJSON)
    message = JSON::parse(messageJSON)

    @component.send(message["type"], *message["args"])
  end
end

module Prism::DOM
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
    define_method(tag.to_sym) do |className, options, children|
      options = options || {}
      options[:type] = tag
      options[:class] = className
      options[:children] = children || []

      options
    end
  end

  def text(t)
    {:type => "text", :content => t.to_s}
  end

  def dispatch(sym, *args)
    {:type => sym, :args => args}
  end
end

