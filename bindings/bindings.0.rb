module JS
  class Event < Prism::Binding
    include Prism::BindingHelpers

    # def initialize(type, eventInitDict = UNDEFINED)
    # end

    NONE = 0
    CAPTURING_PHASE = 1
    AT_TARGET = 2
    BUBBLING_PHASE = 3

    bind_attr_reader :type, return_type: 'DOMString'
    bind_attr_reader :target, return_type: 'EventTarget'
    bind_attr_reader :srcElement, return_type: 'EventTarget'
    bind_attr_reader :currentTarget, return_type: 'EventTarget'
    bind_attr_reader :eventPhase, return_type: 'unsigned short'
    bind_attr_reader :bubbles, return_type: 'boolean'
    bind_attr_reader :cancelable, return_type: 'boolean'
    bind_attr_reader :defaultPrevented, return_type: 'boolean'
    bind_attr_reader :composed, return_type: 'boolean'
    bind_attr_reader :isTrusted, return_type: 'boolean'
    bind_attr_reader :timeStamp, return_type: 'DOMHighResTimeStamp'

    bind_attr_accessor :cancelBubble, return_type: 'boolean'
    bind_attr_accessor :returnValue, return_type: 'boolean'

    bind_operation :composedPath, return_type: 'EventTarget', args: []
    bind_operation :stopPropagation, return_type: 'undefined', args: []
    bind_operation :stopImmediatePropagation, return_type: 'undefined', args: []
    bind_operation :preventDefault, return_type: 'undefined', args: []
    bind_operation :initEvent, return_type: 'undefined', args: [
      {"name":"type","type":"DOMString","optional":false},
      {"name":"bubbles","type":"boolean","optional":true},
      {"name":"cancelable","type":"boolean","optional":true}
    ]
  end

  # Skipped definition, name=EventInit, type='dictionary':
  # {
  #   "type": "dictionary",
  #   "name": "EventInit",
  #   "inheritance": null,
  #   "members": [
  #     {
  #       "type": "field",
  #       "name": "bubbles",
  #       "extAttrs": [],
  #       "idlType": {
  #         "type": "dictionary-type",
  #         "extAttrs": [],
  #         "generic": "",
  #         "nullable": false,
  #         "union": false,
  #         "idlType": "boolean"
  #       },
  #       "default": {
  #         "type": "boolean",
  #         "value": false
  #       },
  #       "required": false
  #     },
  #     {
  #       "type": "field",
  #       "name": "cancelable",
  #       "extAttrs": [],
  #       "idlType": {
  #         "type": "dictionary-type",
  #         "extAttrs": [],
  #         "generic": "",
  #         "nullable": false,
  #         "union": false,
  #         "idlType": "boolean"
  #       },
  #       "default": {
  #         "type": "boolean",
  #         "value": false
  #       },
  #       "required": false
  #     },
  #     {
  #       "type": "field",
  #       "name": "composed",
  #       "extAttrs": [],
  #       "idlType": {
  #         "type": "dictionary-type",
  #         "extAttrs": [],
  #         "generic": "",
  #         "nullable": false,
  #         "union": false,
  #         "idlType": "boolean"
  #       },
  #       "default": {
  #         "type": "boolean",
  #         "value": false
  #       },
  #       "required": false
  #     }
  #   ],
  #   "extAttrs": [],
  #   "partial": false
  # }

  class CustomEvent < Event
    include Prism::BindingHelpers

    # def initialize(type, eventInitDict = UNDEFINED)
    # end

    bind_attr_reader :detail, return_type: 'any'

    bind_operation :initCustomEvent, return_type: 'undefined', args: [
      {"name":"type","type":"DOMString","optional":false},
      {"name":"bubbles","type":"boolean","optional":true},
      {"name":"cancelable","type":"boolean","optional":true},
      {"name":"detail","type":"any","optional":true}
    ]
  end

  # Skipped definition, name=CustomEventInit, type='dictionary':
  # {
  #   "type": "dictionary",
  #   "name": "CustomEventInit",
  #   "inheritance": "EventInit",
  #   "members": [
  #     {
  #       "type": "field",
  #       "name": "detail",
  #       "extAttrs": [],
  #       "idlType": {
  #         "type": "dictionary-type",
  #         "extAttrs": [],
  #         "generic": "",
  #         "nullable": false,
  #         "union": false,
  #         "idlType": "any"
  #       },
  #       "default": {
  #         "type": "null"
  #       },
  #       "required": false
  #     }
  #   ],
  #   "extAttrs": [],
  #   "partial": false
  # }

  class EventTarget < Prism::Binding
    include Prism::BindingHelpers

    # def initialize()
    # end

    bind_operation :addEventListener, return_type: 'undefined', args: [
      {"name":"type","type":"DOMString","optional":false},
      {"name":"callback","type":"EventListener","optional":false},
      {"name":"options","type":"AddEventListenerOptions | boolean","optional":true}
    ]
    bind_operation :removeEventListener, return_type: 'undefined', args: [
      {"name":"type","type":"DOMString","optional":false},
      {"name":"callback","type":"EventListener","optional":false},
      {"name":"options","type":"EventListenerOptions | boolean","optional":true}
    ]
    bind_operation :dispatchEvent, return_type: 'boolean', args: [
      {"name":"event","type":"Event","optional":false}
    ]
  end

  EventListener = CallbackInterface.new("EventListener", return_type: "undefined", args: [
    {"name":"event","type":"Event","optional":false}
  ])

  # Skipped definition, name=EventListenerOptions, type='dictionary':
  # {
  #   "type": "dictionary",
  #   "name": "EventListenerOptions",
  #   "inheritance": null,
  #   "members": [
  #     {
  #       "type": "field",
  #       "name": "capture",
  #       "extAttrs": [],
  #       "idlType": {
  #         "type": "dictionary-type",
  #         "extAttrs": [],
  #         "generic": "",
  #         "nullable": false,
  #         "union": false,
  #         "idlType": "boolean"
  #       },
  #       "default": {
  #         "type": "boolean",
  #         "value": false
  #       },
  #       "required": false
  #     }
  #   ],
  #   "extAttrs": [],
  #   "partial": false
  # }

  # Skipped definition, name=AddEventListenerOptions, type='dictionary':
  # {
  #   "type": "dictionary",
  #   "name": "AddEventListenerOptions",
  #   "inheritance": "EventListenerOptions",
  #   "members": [
  #     {
  #       "type": "field",
  #       "name": "passive",
  #       "extAttrs": [],
  #       "idlType": {
  #         "type": "dictionary-type",
  #         "extAttrs": [],
  #         "generic": "",
  #         "nullable": false,
  #         "union": false,
  #         "idlType": "boolean"
  #       },
  #       "default": {
  #         "type": "boolean",
  #         "value": false
  #       },
  #       "required": false
  #     },
  #     {
  #       "type": "field",
  #       "name": "once",
  #       "extAttrs": [],
  #       "idlType": {
  #         "type": "dictionary-type",
  #         "extAttrs": [],
  #         "generic": "",
  #         "nullable": false,
  #         "union": false,
  #         "idlType": "boolean"
  #       },
  #       "default": {
  #         "type": "boolean",
  #         "value": false
  #       },
  #       "required": false
  #     },
  #     {
  #       "type": "field",
  #       "name": "signal",
  #       "extAttrs": [],
  #       "idlType": {
  #         "type": "dictionary-type",
  #         "extAttrs": [],
  #         "generic": "",
  #         "nullable": false,
  #         "union": false,
  #         "idlType": "AbortSignal"
  #       },
  #       "default": null,
  #       "required": false
  #     }
  #   ],
  #   "extAttrs": [],
  #   "partial": false
  # }

  class AbortController < Prism::Binding
    include Prism::BindingHelpers

    # def initialize()
    # end

    bind_attr_reader :signal, return_type: 'AbortSignal'

    bind_operation :abort, return_type: 'undefined', args: []
  end

  class AbortSignal < EventTarget
    include Prism::BindingHelpers

    bind_attr_reader :aborted, return_type: 'boolean'

    bind_attr_accessor :onabort, return_type: 'EventHandler'

    bind_operation :abort, return_type: 'AbortSignal', args: []
  end

  module NonElementParentNode
    include Prism::BindingHelpers

    bind_operation :getElementById, return_type: 'Element', args: [
      {"name":"elementId","type":"DOMString","optional":false}
    ]
  end

  module DocumentOrShadowRoot
    include Prism::BindingHelpers


  end

  module ParentNode
    include Prism::BindingHelpers

    bind_attr_reader :children, return_type: 'HTMLCollection'
    bind_attr_reader :firstElementChild, return_type: 'Element'
    bind_attr_reader :lastElementChild, return_type: 'Element'
    bind_attr_reader :childElementCount, return_type: 'unsigned long'

    bind_operation :prepend, return_type: 'undefined', args: [
      {"name":"nodes","type":"Node | DOMString","optional":false}
    ]
    bind_operation :append, return_type: 'undefined', args: [
      {"name":"nodes","type":"Node | DOMString","optional":false}
    ]
    bind_operation :replaceChildren, return_type: 'undefined', args: [
      {"name":"nodes","type":"Node | DOMString","optional":false}
    ]
    bind_operation :querySelector, return_type: 'Element', args: [
      {"name":"selectors","type":"DOMString","optional":false}
    ]
    bind_operation :querySelectorAll, return_type: 'NodeList', args: [
      {"name":"selectors","type":"DOMString","optional":false}
    ]
  end

  module NonDocumentTypeChildNode
    include Prism::BindingHelpers

    bind_attr_reader :previousElementSibling, return_type: 'Element'
    bind_attr_reader :nextElementSibling, return_type: 'Element'
  end

  module ChildNode
    include Prism::BindingHelpers

    bind_operation :before, return_type: 'undefined', args: [
      {"name":"nodes","type":"Node | DOMString","optional":false}
    ]
    bind_operation :after, return_type: 'undefined', args: [
      {"name":"nodes","type":"Node | DOMString","optional":false}
    ]
    bind_operation :replaceWith, return_type: 'undefined', args: [
      {"name":"nodes","type":"Node | DOMString","optional":false}
    ]
    bind_operation :remove, return_type: 'undefined', args: []
  end

  module Slottable
    include Prism::BindingHelpers

    bind_attr_reader :assignedSlot, return_type: 'HTMLSlotElement'
  end

  class NodeList < Prism::Binding
    include Prism::BindingHelpers

    bind_attr_reader :length, return_type: 'unsigned long'

    bind_operation :item, return_type: 'Node', args: [
      {"name":"index","type":"unsigned long","optional":false}
    ]

    # !!! Unknown member type: iterable
    # {
    #   "type": "iterable",
    #   "idlType": [
    #     {
    #       "type": null,
    #       "extAttrs": [],
    #       "generic": "",
    #       "nullable": false,
    #       "union": false,
    #       "idlType": "Node"
    #     }
    #   ],
    #   "arguments": [],
    #   "extAttrs": [],
    #   "readonly": false,
    #   "async": false
    # }
  end

  class HTMLCollection < Prism::Binding
    include Prism::BindingHelpers

    bind_attr_reader :length, return_type: 'unsigned long'

    bind_operation :item, return_type: 'Element', args: [
      {"name":"index","type":"unsigned long","optional":false}
    ]
    bind_operation :namedItem, return_type: 'Element', args: [
      {"name":"name","type":"DOMString","optional":false}
    ]
  end

  class MutationObserver < Prism::Binding
    include Prism::BindingHelpers

    # def initialize(callback)
    # end

    bind_operation :observe, return_type: 'undefined', args: [
      {"name":"target","type":"Node","optional":false},
      {"name":"options","type":"MutationObserverInit","optional":true}
    ]
    bind_operation :disconnect, return_type: 'undefined', args: []
    bind_operation :takeRecords, return_type: 'MutationRecord', args: []
  end

  MutationCallback = CallbackInterface.new("MutationCallback", args: [
    {"name":"mutations","type":"MutationRecord","optional":false},
    {"name":"observer","type":"MutationObserver","optional":false}
  ])

  # Skipped definition, name=MutationObserverInit, type='dictionary':
  # {
  #   "type": "dictionary",
  #   "name": "MutationObserverInit",
  #   "inheritance": null,
  #   "members": [
  #     {
  #       "type": "field",
  #       "name": "childList",
  #       "extAttrs": [],
  #       "idlType": {
  #         "type": "dictionary-type",
  #         "extAttrs": [],
  #         "generic": "",
  #         "nullable": false,
  #         "union": false,
  #         "idlType": "boolean"
  #       },
  #       "default": {
  #         "type": "boolean",
  #         "value": false
  #       },
  #       "required": false
  #     },
  #     {
  #       "type": "field",
  #       "name": "attributes",
  #       "extAttrs": [],
  #       "idlType": {
  #         "type": "dictionary-type",
  #         "extAttrs": [],
  #         "generic": "",
  #         "nullable": false,
  #         "union": false,
  #         "idlType": "boolean"
  #       },
  #       "default": null,
  #       "required": false
  #     },
  #     {
  #       "type": "field",
  #       "name": "characterData",
  #       "extAttrs": [],
  #       "idlType": {
  #         "type": "dictionary-type",
  #         "extAttrs": [],
  #         "generic": "",
  #         "nullable": false,
  #         "union": false,
  #         "idlType": "boolean"
  #       },
  #       "default": null,
  #       "required": false
  #     },
  #     {
  #       "type": "field",
  #       "name": "subtree",
  #       "extAttrs": [],
  #       "idlType": {
  #         "type": "dictionary-type",
  #         "extAttrs": [],
  #         "generic": "",
  #         "nullable": false,
  #         "union": false,
  #         "idlType": "boolean"
  #       },
  #       "default": {
  #         "type": "boolean",
  #         "value": false
  #       },
  #       "required": false
  #     },
  #     {
  #       "type": "field",
  #       "name": "attributeOldValue",
  #       "extAttrs": [],
  #       "idlType": {
  #         "type": "dictionary-type",
  #         "extAttrs": [],
  #         "generic": "",
  #         "nullable": false,
  #         "union": false,
  #         "idlType": "boolean"
  #       },
  #       "default": null,
  #       "required": false
  #     },
  #     {
  #       "type": "field",
  #       "name": "characterDataOldValue",
  #       "extAttrs": [],
  #       "idlType": {
  #         "type": "dictionary-type",
  #         "extAttrs": [],
  #         "generic": "",
  #         "nullable": false,
  #         "union": false,
  #         "idlType": "boolean"
  #       },
  #       "default": null,
  #       "required": false
  #     },
  #     {
  #       "type": "field",
  #       "name": "attributeFilter",
  #       "extAttrs": [],
  #       "idlType": {
  #         "type": "dictionary-type",
  #         "extAttrs": [],
  #         "generic": "sequence",
  #         "nullable": false,
  #         "union": false,
  #         "idlType": [
  #           {
  #             "type": "dictionary-type",
  #             "extAttrs": [],
  #             "generic": "",
  #             "nullable": false,
  #             "union": false,
  #             "idlType": "DOMString"
  #           }
  #         ]
  #       },
  #       "default": null,
  #       "required": false
  #     }
  #   ],
  #   "extAttrs": [],
  #   "partial": false
  # }

  class MutationRecord < Prism::Binding
    include Prism::BindingHelpers

    bind_attr_reader :type, return_type: 'DOMString'
    bind_attr_reader :target, return_type: 'Node'
    bind_attr_reader :addedNodes, return_type: 'NodeList'
    bind_attr_reader :removedNodes, return_type: 'NodeList'
    bind_attr_reader :previousSibling, return_type: 'Node'
    bind_attr_reader :nextSibling, return_type: 'Node'
    bind_attr_reader :attributeName, return_type: 'DOMString'
    bind_attr_reader :attributeNamespace, return_type: 'DOMString'
    bind_attr_reader :oldValue, return_type: 'DOMString'
  end

  class Node < EventTarget
    include Prism::BindingHelpers

    ELEMENT_NODE = 1
    ATTRIBUTE_NODE = 2
    TEXT_NODE = 3
    CDATA_SECTION_NODE = 4
    ENTITY_REFERENCE_NODE = 5
    ENTITY_NODE = 6
    PROCESSING_INSTRUCTION_NODE = 7
    COMMENT_NODE = 8
    DOCUMENT_NODE = 9
    DOCUMENT_TYPE_NODE = 10
    DOCUMENT_FRAGMENT_NODE = 11
    NOTATION_NODE = 12
    DOCUMENT_POSITION_DISCONNECTED = 0x01
    DOCUMENT_POSITION_PRECEDING = 0x02
    DOCUMENT_POSITION_FOLLOWING = 0x04
    DOCUMENT_POSITION_CONTAINS = 0x08
    DOCUMENT_POSITION_CONTAINED_BY = 0x10
    DOCUMENT_POSITION_IMPLEMENTATION_SPECIFIC = 0x20

    bind_attr_reader :nodeType, return_type: 'unsigned short'
    bind_attr_reader :nodeName, return_type: 'DOMString'
    bind_attr_reader :baseURI, return_type: 'USVString'
    bind_attr_reader :isConnected, return_type: 'boolean'
    bind_attr_reader :ownerDocument, return_type: 'Document'
    bind_attr_reader :parentNode, return_type: 'Node'
    bind_attr_reader :parentElement, return_type: 'Element'
    bind_attr_reader :childNodes, return_type: 'NodeList'
    bind_attr_reader :firstChild, return_type: 'Node'
    bind_attr_reader :lastChild, return_type: 'Node'
    bind_attr_reader :previousSibling, return_type: 'Node'
    bind_attr_reader :nextSibling, return_type: 'Node'

    bind_attr_accessor :nodeValue, return_type: 'DOMString'
    bind_attr_accessor :textContent, return_type: 'DOMString'

    bind_operation :getRootNode, return_type: 'Node', args: [
      {"name":"options","type":"GetRootNodeOptions","optional":true}
    ]
    bind_operation :hasChildNodes, return_type: 'boolean', args: []
    bind_operation :normalize, return_type: 'undefined', args: []
    bind_operation :cloneNode, return_type: 'Node', args: [
      {"name":"deep","type":"boolean","optional":true}
    ]
    bind_operation :isEqualNode, return_type: 'boolean', args: [
      {"name":"otherNode","type":"Node","optional":false}
    ]
    bind_operation :isSameNode, return_type: 'boolean', args: [
      {"name":"otherNode","type":"Node","optional":false}
    ]
    bind_operation :compareDocumentPosition, return_type: 'unsigned short', args: [
      {"name":"other","type":"Node","optional":false}
    ]
    bind_operation :contains, return_type: 'boolean', args: [
      {"name":"other","type":"Node","optional":false}
    ]
    bind_operation :lookupPrefix, return_type: 'DOMString', args: [
      {"name":"namespace","type":"DOMString","optional":false}
    ]
    bind_operation :lookupNamespaceURI, return_type: 'DOMString', args: [
      {"name":"prefix","type":"DOMString","optional":false}
    ]
    bind_operation :isDefaultNamespace, return_type: 'boolean', args: [
      {"name":"namespace","type":"DOMString","optional":false}
    ]
    bind_operation :insertBefore, return_type: 'Node', args: [
      {"name":"node","type":"Node","optional":false},
      {"name":"child","type":"Node","optional":false}
    ]
    bind_operation :appendChild, return_type: 'Node', args: [
      {"name":"node","type":"Node","optional":false}
    ]
    bind_operation :replaceChild, return_type: 'Node', args: [
      {"name":"node","type":"Node","optional":false},
      {"name":"child","type":"Node","optional":false}
    ]
    bind_operation :removeChild, return_type: 'Node', args: [
      {"name":"child","type":"Node","optional":false}
    ]
  end

  # Skipped definition, name=GetRootNodeOptions, type='dictionary':
  # {
  #   "type": "dictionary",
  #   "name": "GetRootNodeOptions",
  #   "inheritance": null,
  #   "members": [
  #     {
  #       "type": "field",
  #       "name": "composed",
  #       "extAttrs": [],
  #       "idlType": {
  #         "type": "dictionary-type",
  #         "extAttrs": [],
  #         "generic": "",
  #         "nullable": false,
  #         "union": false,
  #         "idlType": "boolean"
  #       },
  #       "default": {
  #         "type": "boolean",
  #         "value": false
  #       },
  #       "required": false
  #     }
  #   ],
  #   "extAttrs": [],
  #   "partial": false
  # }

  class Document < Node
    include Prism::BindingHelpers

    # def initialize()
    # end

    bind_attr_reader :implementation, return_type: 'DOMImplementation'
    bind_attr_reader :URL, return_type: 'USVString'
    bind_attr_reader :documentURI, return_type: 'USVString'
    bind_attr_reader :compatMode, return_type: 'DOMString'
    bind_attr_reader :characterSet, return_type: 'DOMString'
    bind_attr_reader :charset, return_type: 'DOMString'
    bind_attr_reader :inputEncoding, return_type: 'DOMString'
    bind_attr_reader :contentType, return_type: 'DOMString'
    bind_attr_reader :doctype, return_type: 'DocumentType'
    bind_attr_reader :documentElement, return_type: 'Element'

    bind_operation :getElementsByTagName, return_type: 'HTMLCollection', args: [
      {"name":"qualifiedName","type":"DOMString","optional":false}
    ]
    bind_operation :getElementsByTagNameNS, return_type: 'HTMLCollection', args: [
      {"name":"namespace","type":"DOMString","optional":false},
      {"name":"localName","type":"DOMString","optional":false}
    ]
    bind_operation :getElementsByClassName, return_type: 'HTMLCollection', args: [
      {"name":"classNames","type":"DOMString","optional":false}
    ]
    bind_operation :createElement, return_type: 'Element', args: [
      {"name":"localName","type":"DOMString","optional":false},
      {"name":"options","type":"DOMString | ElementCreationOptions","optional":true}
    ]
    bind_operation :createElementNS, return_type: 'Element', args: [
      {"name":"namespace","type":"DOMString","optional":false},
      {"name":"qualifiedName","type":"DOMString","optional":false},
      {"name":"options","type":"DOMString | ElementCreationOptions","optional":true}
    ]
    bind_operation :createDocumentFragment, return_type: 'DocumentFragment', args: []
    bind_operation :createTextNode, return_type: 'Text', args: [
      {"name":"data","type":"DOMString","optional":false}
    ]
    bind_operation :createCDATASection, return_type: 'CDATASection', args: [
      {"name":"data","type":"DOMString","optional":false}
    ]
    bind_operation :createComment, return_type: 'Comment', args: [
      {"name":"data","type":"DOMString","optional":false}
    ]
    bind_operation :createProcessingInstruction, return_type: 'ProcessingInstruction', args: [
      {"name":"target","type":"DOMString","optional":false},
      {"name":"data","type":"DOMString","optional":false}
    ]
    bind_operation :importNode, return_type: 'Node', args: [
      {"name":"node","type":"Node","optional":false},
      {"name":"deep","type":"boolean","optional":true}
    ]
    bind_operation :adoptNode, return_type: 'Node', args: [
      {"name":"node","type":"Node","optional":false}
    ]
    bind_operation :createAttribute, return_type: 'Attr', args: [
      {"name":"localName","type":"DOMString","optional":false}
    ]
    bind_operation :createAttributeNS, return_type: 'Attr', args: [
      {"name":"namespace","type":"DOMString","optional":false},
      {"name":"qualifiedName","type":"DOMString","optional":false}
    ]
    bind_operation :createEvent, return_type: 'Event', args: [
      {"name":"interface","type":"DOMString","optional":false}
    ]
    bind_operation :createRange, return_type: 'Range', args: []
    bind_operation :createNodeIterator, return_type: 'NodeIterator', args: [
      {"name":"root","type":"Node","optional":false},
      {"name":"whatToShow","type":"unsigned long","optional":true},
      {"name":"filter","type":"NodeFilter","optional":true}
    ]
    bind_operation :createTreeWalker, return_type: 'TreeWalker', args: [
      {"name":"root","type":"Node","optional":false},
      {"name":"whatToShow","type":"unsigned long","optional":true},
      {"name":"filter","type":"NodeFilter","optional":true}
    ]
  end

  class XMLDocument < Document
    include Prism::BindingHelpers


  end

  # Skipped definition, name=ElementCreationOptions, type='dictionary':
  # {
  #   "type": "dictionary",
  #   "name": "ElementCreationOptions",
  #   "inheritance": null,
  #   "members": [
  #     {
  #       "type": "field",
  #       "name": "is",
  #       "extAttrs": [],
  #       "idlType": {
  #         "type": "dictionary-type",
  #         "extAttrs": [],
  #         "generic": "",
  #         "nullable": false,
  #         "union": false,
  #         "idlType": "DOMString"
  #       },
  #       "default": null,
  #       "required": false
  #     }
  #   ],
  #   "extAttrs": [],
  #   "partial": false
  # }

  class DOMImplementation < Prism::Binding
    include Prism::BindingHelpers

    bind_operation :createDocumentType, return_type: 'DocumentType', args: [
      {"name":"qualifiedName","type":"DOMString","optional":false},
      {"name":"publicId","type":"DOMString","optional":false},
      {"name":"systemId","type":"DOMString","optional":false}
    ]
    bind_operation :createDocument, return_type: 'XMLDocument', args: [
      {"name":"namespace","type":"DOMString","optional":false},
      {"name":"qualifiedName","type":"DOMString","optional":false},
      {"name":"doctype","type":"DocumentType","optional":true}
    ]
    bind_operation :createHTMLDocument, return_type: 'Document', args: [
      {"name":"title","type":"DOMString","optional":true}
    ]
    bind_operation :hasFeature, return_type: 'boolean', args: []
  end

  class DocumentType < Node
    include Prism::BindingHelpers

    bind_attr_reader :name, return_type: 'DOMString'
    bind_attr_reader :publicId, return_type: 'DOMString'
    bind_attr_reader :systemId, return_type: 'DOMString'
  end

  class DocumentFragment < Node
    include Prism::BindingHelpers

    # def initialize()
    # end
  end

  class ShadowRoot < DocumentFragment
    include Prism::BindingHelpers

    bind_attr_reader :mode, return_type: 'ShadowRootMode'
    bind_attr_reader :delegatesFocus, return_type: 'boolean'
    bind_attr_reader :slotAssignment, return_type: 'SlotAssignmentMode'
    bind_attr_reader :host, return_type: 'Element'

    bind_attr_accessor :onslotchange, return_type: 'EventHandler'
  end

  # Skipped definition, name=ShadowRootMode, type='enum':
  # {
  #   "type": "enum",
  #   "name": "ShadowRootMode",
  #   "values": [
  #     {
  #       "type": "enum-value",
  #       "value": "open"
  #     },
  #     {
  #       "type": "enum-value",
  #       "value": "closed"
  #     }
  #   ],
  #   "extAttrs": []
  # }

  # Skipped definition, name=SlotAssignmentMode, type='enum':
  # {
  #   "type": "enum",
  #   "name": "SlotAssignmentMode",
  #   "values": [
  #     {
  #       "type": "enum-value",
  #       "value": "manual"
  #     },
  #     {
  #       "type": "enum-value",
  #       "value": "named"
  #     }
  #   ],
  #   "extAttrs": []
  # }

  class Element < Node
    include Prism::BindingHelpers

    bind_attr_reader :namespaceURI, return_type: 'DOMString'
    bind_attr_reader :prefix, return_type: 'DOMString'
    bind_attr_reader :localName, return_type: 'DOMString'
    bind_attr_reader :tagName, return_type: 'DOMString'
    bind_attr_reader :classList, return_type: 'DOMTokenList'
    bind_attr_reader :attributes, return_type: 'NamedNodeMap'
    bind_attr_reader :shadowRoot, return_type: 'ShadowRoot'

    bind_attr_accessor :id, return_type: 'DOMString'
    bind_attr_accessor :className, return_type: 'DOMString'
    bind_attr_accessor :slot, return_type: 'DOMString'

    bind_operation :hasAttributes, return_type: 'boolean', args: []
    bind_operation :getAttributeNames, return_type: 'DOMString', args: []
    bind_operation :getAttribute, return_type: 'DOMString', args: [
      {"name":"qualifiedName","type":"DOMString","optional":false}
    ]
    bind_operation :getAttributeNS, return_type: 'DOMString', args: [
      {"name":"namespace","type":"DOMString","optional":false},
      {"name":"localName","type":"DOMString","optional":false}
    ]
    bind_operation :setAttribute, return_type: 'undefined', args: [
      {"name":"qualifiedName","type":"DOMString","optional":false},
      {"name":"value","type":"DOMString","optional":false}
    ]
    bind_operation :setAttributeNS, return_type: 'undefined', args: [
      {"name":"namespace","type":"DOMString","optional":false},
      {"name":"qualifiedName","type":"DOMString","optional":false},
      {"name":"value","type":"DOMString","optional":false}
    ]
    bind_operation :removeAttribute, return_type: 'undefined', args: [
      {"name":"qualifiedName","type":"DOMString","optional":false}
    ]
    bind_operation :removeAttributeNS, return_type: 'undefined', args: [
      {"name":"namespace","type":"DOMString","optional":false},
      {"name":"localName","type":"DOMString","optional":false}
    ]
    bind_operation :toggleAttribute, return_type: 'boolean', args: [
      {"name":"qualifiedName","type":"DOMString","optional":false},
      {"name":"force","type":"boolean","optional":true}
    ]
    bind_operation :hasAttribute, return_type: 'boolean', args: [
      {"name":"qualifiedName","type":"DOMString","optional":false}
    ]
    bind_operation :hasAttributeNS, return_type: 'boolean', args: [
      {"name":"namespace","type":"DOMString","optional":false},
      {"name":"localName","type":"DOMString","optional":false}
    ]
    bind_operation :getAttributeNode, return_type: 'Attr', args: [
      {"name":"qualifiedName","type":"DOMString","optional":false}
    ]
    bind_operation :getAttributeNodeNS, return_type: 'Attr', args: [
      {"name":"namespace","type":"DOMString","optional":false},
      {"name":"localName","type":"DOMString","optional":false}
    ]
    bind_operation :setAttributeNode, return_type: 'Attr', args: [
      {"name":"attr","type":"Attr","optional":false}
    ]
    bind_operation :setAttributeNodeNS, return_type: 'Attr', args: [
      {"name":"attr","type":"Attr","optional":false}
    ]
    bind_operation :removeAttributeNode, return_type: 'Attr', args: [
      {"name":"attr","type":"Attr","optional":false}
    ]
    bind_operation :attachShadow, return_type: 'ShadowRoot', args: [
      {"name":"init","type":"ShadowRootInit","optional":false}
    ]
    bind_operation :closest, return_type: 'Element', args: [
      {"name":"selectors","type":"DOMString","optional":false}
    ]
    bind_operation :matches, return_type: 'boolean', args: [
      {"name":"selectors","type":"DOMString","optional":false}
    ]
    bind_operation :webkitMatchesSelector, return_type: 'boolean', args: [
      {"name":"selectors","type":"DOMString","optional":false}
    ]
    bind_operation :getElementsByTagName, return_type: 'HTMLCollection', args: [
      {"name":"qualifiedName","type":"DOMString","optional":false}
    ]
    bind_operation :getElementsByTagNameNS, return_type: 'HTMLCollection', args: [
      {"name":"namespace","type":"DOMString","optional":false},
      {"name":"localName","type":"DOMString","optional":false}
    ]
    bind_operation :getElementsByClassName, return_type: 'HTMLCollection', args: [
      {"name":"classNames","type":"DOMString","optional":false}
    ]
    bind_operation :insertAdjacentElement, return_type: 'Element', args: [
      {"name":"where","type":"DOMString","optional":false},
      {"name":"element","type":"Element","optional":false}
    ]
    bind_operation :insertAdjacentText, return_type: 'undefined', args: [
      {"name":"where","type":"DOMString","optional":false},
      {"name":"data","type":"DOMString","optional":false}
    ]
  end

  # Skipped definition, name=ShadowRootInit, type='dictionary':
  # {
  #   "type": "dictionary",
  #   "name": "ShadowRootInit",
  #   "inheritance": null,
  #   "members": [
  #     {
  #       "type": "field",
  #       "name": "mode",
  #       "extAttrs": [],
  #       "idlType": {
  #         "type": "dictionary-type",
  #         "extAttrs": [],
  #         "generic": "",
  #         "nullable": false,
  #         "union": false,
  #         "idlType": "ShadowRootMode"
  #       },
  #       "default": null,
  #       "required": true
  #     },
  #     {
  #       "type": "field",
  #       "name": "delegatesFocus",
  #       "extAttrs": [],
  #       "idlType": {
  #         "type": "dictionary-type",
  #         "extAttrs": [],
  #         "generic": "",
  #         "nullable": false,
  #         "union": false,
  #         "idlType": "boolean"
  #       },
  #       "default": {
  #         "type": "boolean",
  #         "value": false
  #       },
  #       "required": false
  #     },
  #     {
  #       "type": "field",
  #       "name": "slotAssignment",
  #       "extAttrs": [],
  #       "idlType": {
  #         "type": "dictionary-type",
  #         "extAttrs": [],
  #         "generic": "",
  #         "nullable": false,
  #         "union": false,
  #         "idlType": "SlotAssignmentMode"
  #       },
  #       "default": {
  #         "type": "string",
  #         "value": "named"
  #       },
  #       "required": false
  #     }
  #   ],
  #   "extAttrs": [],
  #   "partial": false
  # }

  class NamedNodeMap < Prism::Binding
    include Prism::BindingHelpers

    bind_attr_reader :length, return_type: 'unsigned long'

    bind_operation :item, return_type: 'Attr', args: [
      {"name":"index","type":"unsigned long","optional":false}
    ]
    bind_operation :getNamedItem, return_type: 'Attr', args: [
      {"name":"qualifiedName","type":"DOMString","optional":false}
    ]
    bind_operation :getNamedItemNS, return_type: 'Attr', args: [
      {"name":"namespace","type":"DOMString","optional":false},
      {"name":"localName","type":"DOMString","optional":false}
    ]
    bind_operation :setNamedItem, return_type: 'Attr', args: [
      {"name":"attr","type":"Attr","optional":false}
    ]
    bind_operation :setNamedItemNS, return_type: 'Attr', args: [
      {"name":"attr","type":"Attr","optional":false}
    ]
    bind_operation :removeNamedItem, return_type: 'Attr', args: [
      {"name":"qualifiedName","type":"DOMString","optional":false}
    ]
    bind_operation :removeNamedItemNS, return_type: 'Attr', args: [
      {"name":"namespace","type":"DOMString","optional":false},
      {"name":"localName","type":"DOMString","optional":false}
    ]
  end

  class Attr < Node
    include Prism::BindingHelpers

    bind_attr_reader :namespaceURI, return_type: 'DOMString'
    bind_attr_reader :prefix, return_type: 'DOMString'
    bind_attr_reader :localName, return_type: 'DOMString'
    bind_attr_reader :name, return_type: 'DOMString'
    bind_attr_reader :ownerElement, return_type: 'Element'
    bind_attr_reader :specified, return_type: 'boolean'

    bind_attr_accessor :value, return_type: 'DOMString'
  end

  class CharacterData < Node
    include Prism::BindingHelpers

    bind_attr_reader :length, return_type: 'unsigned long'

    bind_attr_accessor :data, return_type: 'DOMString'

    bind_operation :substringData, return_type: 'DOMString', args: [
      {"name":"offset","type":"unsigned long","optional":false},
      {"name":"count","type":"unsigned long","optional":false}
    ]
    bind_operation :appendData, return_type: 'undefined', args: [
      {"name":"data","type":"DOMString","optional":false}
    ]
    bind_operation :insertData, return_type: 'undefined', args: [
      {"name":"offset","type":"unsigned long","optional":false},
      {"name":"data","type":"DOMString","optional":false}
    ]
    bind_operation :deleteData, return_type: 'undefined', args: [
      {"name":"offset","type":"unsigned long","optional":false},
      {"name":"count","type":"unsigned long","optional":false}
    ]
    bind_operation :replaceData, return_type: 'undefined', args: [
      {"name":"offset","type":"unsigned long","optional":false},
      {"name":"count","type":"unsigned long","optional":false},
      {"name":"data","type":"DOMString","optional":false}
    ]
  end

  class Text < CharacterData
    include Prism::BindingHelpers

    # def initialize(data = UNDEFINED)
    # end

    bind_attr_reader :wholeText, return_type: 'DOMString'

    bind_operation :splitText, return_type: 'Text', args: [
      {"name":"offset","type":"unsigned long","optional":false}
    ]
  end

  class CDATASection < Text
    include Prism::BindingHelpers


  end

  class ProcessingInstruction < CharacterData
    include Prism::BindingHelpers

    bind_attr_reader :target, return_type: 'DOMString'
  end

  class Comment < CharacterData
    include Prism::BindingHelpers

    # def initialize(data = UNDEFINED)
    # end
  end

  class AbstractRange < Prism::Binding
    include Prism::BindingHelpers

    bind_attr_reader :startContainer, return_type: 'Node'
    bind_attr_reader :startOffset, return_type: 'unsigned long'
    bind_attr_reader :endContainer, return_type: 'Node'
    bind_attr_reader :endOffset, return_type: 'unsigned long'
    bind_attr_reader :collapsed, return_type: 'boolean'
  end

  # Skipped definition, name=StaticRangeInit, type='dictionary':
  # {
  #   "type": "dictionary",
  #   "name": "StaticRangeInit",
  #   "inheritance": null,
  #   "members": [
  #     {
  #       "type": "field",
  #       "name": "startContainer",
  #       "extAttrs": [],
  #       "idlType": {
  #         "type": "dictionary-type",
  #         "extAttrs": [],
  #         "generic": "",
  #         "nullable": false,
  #         "union": false,
  #         "idlType": "Node"
  #       },
  #       "default": null,
  #       "required": true
  #     },
  #     {
  #       "type": "field",
  #       "name": "startOffset",
  #       "extAttrs": [],
  #       "idlType": {
  #         "type": "dictionary-type",
  #         "extAttrs": [],
  #         "generic": "",
  #         "nullable": false,
  #         "union": false,
  #         "idlType": "unsigned long"
  #       },
  #       "default": null,
  #       "required": true
  #     },
  #     {
  #       "type": "field",
  #       "name": "endContainer",
  #       "extAttrs": [],
  #       "idlType": {
  #         "type": "dictionary-type",
  #         "extAttrs": [],
  #         "generic": "",
  #         "nullable": false,
  #         "union": false,
  #         "idlType": "Node"
  #       },
  #       "default": null,
  #       "required": true
  #     },
  #     {
  #       "type": "field",
  #       "name": "endOffset",
  #       "extAttrs": [],
  #       "idlType": {
  #         "type": "dictionary-type",
  #         "extAttrs": [],
  #         "generic": "",
  #         "nullable": false,
  #         "union": false,
  #         "idlType": "unsigned long"
  #       },
  #       "default": null,
  #       "required": true
  #     }
  #   ],
  #   "extAttrs": [],
  #   "partial": false
  # }

  class StaticRange < AbstractRange
    include Prism::BindingHelpers

    # def initialize(init)
    # end
  end

  class Range < AbstractRange
    include Prism::BindingHelpers

    # def initialize()
    # end

    START_TO_START = 0
    START_TO_END = 1
    END_TO_END = 2
    END_TO_START = 3

    bind_attr_reader :commonAncestorContainer, return_type: 'Node'

    bind_operation :setStart, return_type: 'undefined', args: [
      {"name":"node","type":"Node","optional":false},
      {"name":"offset","type":"unsigned long","optional":false}
    ]
    bind_operation :setEnd, return_type: 'undefined', args: [
      {"name":"node","type":"Node","optional":false},
      {"name":"offset","type":"unsigned long","optional":false}
    ]
    bind_operation :setStartBefore, return_type: 'undefined', args: [
      {"name":"node","type":"Node","optional":false}
    ]
    bind_operation :setStartAfter, return_type: 'undefined', args: [
      {"name":"node","type":"Node","optional":false}
    ]
    bind_operation :setEndBefore, return_type: 'undefined', args: [
      {"name":"node","type":"Node","optional":false}
    ]
    bind_operation :setEndAfter, return_type: 'undefined', args: [
      {"name":"node","type":"Node","optional":false}
    ]
    bind_operation :collapse, return_type: 'undefined', args: [
      {"name":"toStart","type":"boolean","optional":true}
    ]
    bind_operation :selectNode, return_type: 'undefined', args: [
      {"name":"node","type":"Node","optional":false}
    ]
    bind_operation :selectNodeContents, return_type: 'undefined', args: [
      {"name":"node","type":"Node","optional":false}
    ]
    bind_operation :compareBoundaryPoints, return_type: 'short', args: [
      {"name":"how","type":"unsigned short","optional":false},
      {"name":"sourceRange","type":"Range","optional":false}
    ]
    bind_operation :deleteContents, return_type: 'undefined', args: []
    bind_operation :extractContents, return_type: 'DocumentFragment', args: []
    bind_operation :cloneContents, return_type: 'DocumentFragment', args: []
    bind_operation :insertNode, return_type: 'undefined', args: [
      {"name":"node","type":"Node","optional":false}
    ]
    bind_operation :surroundContents, return_type: 'undefined', args: [
      {"name":"newParent","type":"Node","optional":false}
    ]
    bind_operation :cloneRange, return_type: 'Range', args: []
    bind_operation :detach, return_type: 'undefined', args: []
    bind_operation :isPointInRange, return_type: 'boolean', args: [
      {"name":"node","type":"Node","optional":false},
      {"name":"offset","type":"unsigned long","optional":false}
    ]
    bind_operation :comparePoint, return_type: 'short', args: [
      {"name":"node","type":"Node","optional":false},
      {"name":"offset","type":"unsigned long","optional":false}
    ]
    bind_operation :intersectsNode, return_type: 'boolean', args: [
      {"name":"node","type":"Node","optional":false}
    ]
    bind_operation :toString, return_type: 'DOMString', args: []
  end

  class NodeIterator < Prism::Binding
    include Prism::BindingHelpers

    bind_attr_reader :root, return_type: 'Node'
    bind_attr_reader :referenceNode, return_type: 'Node'
    bind_attr_reader :pointerBeforeReferenceNode, return_type: 'boolean'
    bind_attr_reader :whatToShow, return_type: 'unsigned long'
    bind_attr_reader :filter, return_type: 'NodeFilter'

    bind_operation :nextNode, return_type: 'Node', args: []
    bind_operation :previousNode, return_type: 'Node', args: []
    bind_operation :detach, return_type: 'undefined', args: []
  end

  class TreeWalker < Prism::Binding
    include Prism::BindingHelpers

    bind_attr_reader :root, return_type: 'Node'
    bind_attr_reader :whatToShow, return_type: 'unsigned long'
    bind_attr_reader :filter, return_type: 'NodeFilter'

    bind_attr_accessor :currentNode, return_type: 'Node'

    bind_operation :parentNode, return_type: 'Node', args: []
    bind_operation :firstChild, return_type: 'Node', args: []
    bind_operation :lastChild, return_type: 'Node', args: []
    bind_operation :previousSibling, return_type: 'Node', args: []
    bind_operation :nextSibling, return_type: 'Node', args: []
    bind_operation :previousNode, return_type: 'Node', args: []
    bind_operation :nextNode, return_type: 'Node', args: []
  end

  # Skipped definition, name=NodeFilter, type='callback interface':
  # {
  #   "type": "callback interface",
  #   "name": "NodeFilter",
  #   "inheritance": null,
  #   "members": [
  #     {
  #       "type": "const",
  #       "name": "FILTER_ACCEPT",
  #       "idlType": {
  #         "type": "const-type",
  #         "extAttrs": [],
  #         "generic": "",
  #         "nullable": false,
  #         "union": false,
  #         "idlType": "unsigned short"
  #       },
  #       "extAttrs": [],
  #       "value": {
  #         "type": "number",
  #         "value": "1"
  #       }
  #     },
  #     {
  #       "type": "const",
  #       "name": "FILTER_REJECT",
  #       "idlType": {
  #         "type": "const-type",
  #         "extAttrs": [],
  #         "generic": "",
  #         "nullable": false,
  #         "union": false,
  #         "idlType": "unsigned short"
  #       },
  #       "extAttrs": [],
  #       "value": {
  #         "type": "number",
  #         "value": "2"
  #       }
  #     },
  #     {
  #       "type": "const",
  #       "name": "FILTER_SKIP",
  #       "idlType": {
  #         "type": "const-type",
  #         "extAttrs": [],
  #         "generic": "",
  #         "nullable": false,
  #         "union": false,
  #         "idlType": "unsigned short"
  #       },
  #       "extAttrs": [],
  #       "value": {
  #         "type": "number",
  #         "value": "3"
  #       }
  #     },
  #     {
  #       "type": "const",
  #       "name": "SHOW_ALL",
  #       "idlType": {
  #         "type": "const-type",
  #         "extAttrs": [],
  #         "generic": "",
  #         "nullable": false,
  #         "union": false,
  #         "idlType": "unsigned long"
  #       },
  #       "extAttrs": [],
  #       "value": {
  #         "type": "number",
  #         "value": "0xFFFFFFFF"
  #       }
  #     },
  #     {
  #       "type": "const",
  #       "name": "SHOW_ELEMENT",
  #       "idlType": {
  #         "type": "const-type",
  #         "extAttrs": [],
  #         "generic": "",
  #         "nullable": false,
  #         "union": false,
  #         "idlType": "unsigned long"
  #       },
  #       "extAttrs": [],
  #       "value": {
  #         "type": "number",
  #         "value": "0x1"
  #       }
  #     },
  #     {
  #       "type": "const",
  #       "name": "SHOW_ATTRIBUTE",
  #       "idlType": {
  #         "type": "const-type",
  #         "extAttrs": [],
  #         "generic": "",
  #         "nullable": false,
  #         "union": false,
  #         "idlType": "unsigned long"
  #       },
  #       "extAttrs": [],
  #       "value": {
  #         "type": "number",
  #         "value": "0x2"
  #       }
  #     },
  #     {
  #       "type": "const",
  #       "name": "SHOW_TEXT",
  #       "idlType": {
  #         "type": "const-type",
  #         "extAttrs": [],
  #         "generic": "",
  #         "nullable": false,
  #         "union": false,
  #         "idlType": "unsigned long"
  #       },
  #       "extAttrs": [],
  #       "value": {
  #         "type": "number",
  #         "value": "0x4"
  #       }
  #     },
  #     {
  #       "type": "const",
  #       "name": "SHOW_CDATA_SECTION",
  #       "idlType": {
  #         "type": "const-type",
  #         "extAttrs": [],
  #         "generic": "",
  #         "nullable": false,
  #         "union": false,
  #         "idlType": "unsigned long"
  #       },
  #       "extAttrs": [],
  #       "value": {
  #         "type": "number",
  #         "value": "0x8"
  #       }
  #     },
  #     {
  #       "type": "const",
  #       "name": "SHOW_ENTITY_REFERENCE",
  #       "idlType": {
  #         "type": "const-type",
  #         "extAttrs": [],
  #         "generic": "",
  #         "nullable": false,
  #         "union": false,
  #         "idlType": "unsigned long"
  #       },
  #       "extAttrs": [],
  #       "value": {
  #         "type": "number",
  #         "value": "0x10"
  #       }
  #     },
  #     {
  #       "type": "const",
  #       "name": "SHOW_ENTITY",
  #       "idlType": {
  #         "type": "const-type",
  #         "extAttrs": [],
  #         "generic": "",
  #         "nullable": false,
  #         "union": false,
  #         "idlType": "unsigned long"
  #       },
  #       "extAttrs": [],
  #       "value": {
  #         "type": "number",
  #         "value": "0x20"
  #       }
  #     },
  #     {
  #       "type": "const",
  #       "name": "SHOW_PROCESSING_INSTRUCTION",
  #       "idlType": {
  #         "type": "const-type",
  #         "extAttrs": [],
  #         "generic": "",
  #         "nullable": false,
  #         "union": false,
  #         "idlType": "unsigned long"
  #       },
  #       "extAttrs": [],
  #       "value": {
  #         "type": "number",
  #         "value": "0x40"
  #       }
  #     },
  #     {
  #       "type": "const",
  #       "name": "SHOW_COMMENT",
  #       "idlType": {
  #         "type": "const-type",
  #         "extAttrs": [],
  #         "generic": "",
  #         "nullable": false,
  #         "union": false,
  #         "idlType": "unsigned long"
  #       },
  #       "extAttrs": [],
  #       "value": {
  #         "type": "number",
  #         "value": "0x80"
  #       }
  #     },
  #     {
  #       "type": "const",
  #       "name": "SHOW_DOCUMENT",
  #       "idlType": {
  #         "type": "const-type",
  #         "extAttrs": [],
  #         "generic": "",
  #         "nullable": false,
  #         "union": false,
  #         "idlType": "unsigned long"
  #       },
  #       "extAttrs": [],
  #       "value": {
  #         "type": "number",
  #         "value": "0x100"
  #       }
  #     },
  #     {
  #       "type": "const",
  #       "name": "SHOW_DOCUMENT_TYPE",
  #       "idlType": {
  #         "type": "const-type",
  #         "extAttrs": [],
  #         "generic": "",
  #         "nullable": false,
  #         "union": false,
  #         "idlType": "unsigned long"
  #       },
  #       "extAttrs": [],
  #       "value": {
  #         "type": "number",
  #         "value": "0x200"
  #       }
  #     },
  #     {
  #       "type": "const",
  #       "name": "SHOW_DOCUMENT_FRAGMENT",
  #       "idlType": {
  #         "type": "const-type",
  #         "extAttrs": [],
  #         "generic": "",
  #         "nullable": false,
  #         "union": false,
  #         "idlType": "unsigned long"
  #       },
  #       "extAttrs": [],
  #       "value": {
  #         "type": "number",
  #         "value": "0x400"
  #       }
  #     },
  #     {
  #       "type": "const",
  #       "name": "SHOW_NOTATION",
  #       "idlType": {
  #         "type": "const-type",
  #         "extAttrs": [],
  #         "generic": "",
  #         "nullable": false,
  #         "union": false,
  #         "idlType": "unsigned long"
  #       },
  #       "extAttrs": [],
  #       "value": {
  #         "type": "number",
  #         "value": "0x800"
  #       }
  #     },
  #     {
  #       "type": "operation",
  #       "name": "acceptNode",
  #       "idlType": {
  #         "type": "return-type",
  #         "extAttrs": [],
  #         "generic": "",
  #         "nullable": false,
  #         "union": false,
  #         "idlType": "unsigned short"
  #       },
  #       "arguments": [
  #         {
  #           "type": "argument",
  #           "name": "node",
  #           "extAttrs": [],
  #           "idlType": {
  #             "type": "argument-type",
  #             "extAttrs": [],
  #             "generic": "",
  #             "nullable": false,
  #             "union": false,
  #             "idlType": "Node"
  #           },
  #           "default": null,
  #           "optional": false,
  #           "variadic": false
  #         }
  #       ],
  #       "extAttrs": [],
  #       "special": ""
  #     }
  #   ],
  #   "extAttrs": [
  #     {
  #       "type": "extended-attribute",
  #       "name": "Exposed",
  #       "rhs": {
  #         "type": "identifier",
  #         "value": "Window"
  #       },
  #       "arguments": []
  #     }
  #   ],
  #   "partial": false
  # }

  class DOMTokenList < Prism::Binding
    include Prism::BindingHelpers

    bind_attr_reader :length, return_type: 'unsigned long'

    bind_attr_accessor :value, return_type: 'DOMString'

    bind_operation :item, return_type: 'DOMString', args: [
      {"name":"index","type":"unsigned long","optional":false}
    ]
    bind_operation :contains, return_type: 'boolean', args: [
      {"name":"token","type":"DOMString","optional":false}
    ]
    bind_operation :add, return_type: 'undefined', args: [
      {"name":"tokens","type":"DOMString","optional":false}
    ]
    bind_operation :remove, return_type: 'undefined', args: [
      {"name":"tokens","type":"DOMString","optional":false}
    ]
    bind_operation :toggle, return_type: 'boolean', args: [
      {"name":"token","type":"DOMString","optional":false},
      {"name":"force","type":"boolean","optional":true}
    ]
    bind_operation :replace, return_type: 'boolean', args: [
      {"name":"token","type":"DOMString","optional":false},
      {"name":"newToken","type":"DOMString","optional":false}
    ]
    bind_operation :supports, return_type: 'boolean', args: [
      {"name":"token","type":"DOMString","optional":false}
    ]

    # !!! Unknown member type: iterable
    # {
    #   "type": "iterable",
    #   "idlType": [
    #     {
    #       "type": null,
    #       "extAttrs": [],
    #       "generic": "",
    #       "nullable": false,
    #       "union": false,
    #       "idlType": "DOMString"
    #     }
    #   ],
    #   "arguments": [],
    #   "extAttrs": [],
    #   "readonly": false,
    #   "async": false
    # }
  end

  class XPathResult < Prism::Binding
    include Prism::BindingHelpers

    ANY_TYPE = 0
    NUMBER_TYPE = 1
    STRING_TYPE = 2
    BOOLEAN_TYPE = 3
    UNORDERED_NODE_ITERATOR_TYPE = 4
    ORDERED_NODE_ITERATOR_TYPE = 5
    UNORDERED_NODE_SNAPSHOT_TYPE = 6
    ORDERED_NODE_SNAPSHOT_TYPE = 7
    ANY_UNORDERED_NODE_TYPE = 8
    FIRST_ORDERED_NODE_TYPE = 9

    bind_attr_reader :resultType, return_type: 'unsigned short'
    bind_attr_reader :numberValue, return_type: 'unrestricted double'
    bind_attr_reader :stringValue, return_type: 'DOMString'
    bind_attr_reader :booleanValue, return_type: 'boolean'
    bind_attr_reader :singleNodeValue, return_type: 'Node'
    bind_attr_reader :invalidIteratorState, return_type: 'boolean'
    bind_attr_reader :snapshotLength, return_type: 'unsigned long'

    bind_operation :iterateNext, return_type: 'Node', args: []
    bind_operation :snapshotItem, return_type: 'Node', args: [
      {"name":"index","type":"unsigned long","optional":false}
    ]
  end

  class XPathExpression < Prism::Binding
    include Prism::BindingHelpers

    bind_operation :evaluate, return_type: 'XPathResult', args: [
      {"name":"contextNode","type":"Node","optional":false},
      {"name":"type","type":"unsigned short","optional":true},
      {"name":"result","type":"XPathResult","optional":true}
    ]
  end

  XPathNSResolver = CallbackInterface.new("XPathNSResolver", return_type: "DOMString", args: [
    {"name":"prefix","type":"DOMString","optional":false}
  ])

  module XPathEvaluatorBase
    include Prism::BindingHelpers

    bind_operation :createExpression, return_type: 'XPathExpression', args: [
      {"name":"expression","type":"DOMString","optional":false},
      {"name":"resolver","type":"XPathNSResolver","optional":true}
    ]
    bind_operation :createNSResolver, return_type: 'XPathNSResolver', args: [
      {"name":"nodeResolver","type":"Node","optional":false}
    ]
    bind_operation :evaluate, return_type: 'XPathResult', args: [
      {"name":"expression","type":"DOMString","optional":false},
      {"name":"contextNode","type":"Node","optional":false},
      {"name":"resolver","type":"XPathNSResolver","optional":true},
      {"name":"type","type":"unsigned short","optional":true},
      {"name":"result","type":"XPathResult","optional":true}
    ]
  end

  class XPathEvaluator < Prism::Binding
    include Prism::BindingHelpers

    # def initialize()
    # end
  end

  class XSLTProcessor < Prism::Binding
    include Prism::BindingHelpers

    # def initialize()
    # end

    bind_operation :importStylesheet, return_type: 'undefined', args: [
      {"name":"style","type":"Node","optional":false}
    ]
    bind_operation :transformToFragment, return_type: 'DocumentFragment', args: [
      {"name":"source","type":"Node","optional":false},
      {"name":"output","type":"Document","optional":false}
    ]
    bind_operation :transformToDocument, return_type: 'Document', args: [
      {"name":"source","type":"Node","optional":false}
    ]
    bind_operation :setParameter, return_type: 'undefined', args: [
      {"name":"namespaceURI","type":"DOMString","optional":false},
      {"name":"localName","type":"DOMString","optional":false},
      {"name":"value","type":"any","optional":false}
    ]
    bind_operation :getParameter, return_type: 'any', args: [
      {"name":"namespaceURI","type":"DOMString","optional":false},
      {"name":"localName","type":"DOMString","optional":false}
    ]
    bind_operation :removeParameter, return_type: 'undefined', args: [
      {"name":"namespaceURI","type":"DOMString","optional":false},
      {"name":"localName","type":"DOMString","optional":false}
    ]
    bind_operation :clearParameters, return_type: 'undefined', args: []
    bind_operation :reset, return_type: 'undefined', args: []
  end

  class HTMLAllCollection < Prism::Binding
    include Prism::BindingHelpers

    bind_attr_reader :length, return_type: 'unsigned long'

    bind_operation :[], return_type: 'Element', args: [
      {"name":"index","type":"unsigned long","optional":false}
    ]
    bind_operation :namedItem, return_type: 'HTMLCollection | Element', args: [
      {"name":"name","type":"DOMString","optional":false}
    ]
    bind_operation :item, return_type: 'HTMLCollection | Element', args: [
      {"name":"nameOrIndex","type":"DOMString","optional":true}
    ]
  end

  class HTMLFormControlsCollection < HTMLCollection
    include Prism::BindingHelpers

    bind_operation :namedItem, return_type: 'RadioNodeList | Element', args: [
      {"name":"name","type":"DOMString","optional":false}
    ]
  end

  class RadioNodeList < NodeList
    include Prism::BindingHelpers

    bind_attr_accessor :value, return_type: 'DOMString'
  end

  class HTMLOptionsCollection < HTMLCollection
    include Prism::BindingHelpers

    bind_attr_accessor :length, return_type: 'unsigned long'
    bind_attr_accessor :selectedIndex, return_type: 'long'

    bind_operation :[]=, return_type: 'undefined', args: [
      {"name":"index","type":"unsigned long","optional":false},
      {"name":"option","type":"HTMLOptionElement","optional":false}
    ]
    bind_operation :add, return_type: 'undefined', args: [
      {"name":"element","type":"HTMLOptionElement | HTMLOptGroupElement","optional":false},
      {"name":"before","type":"HTMLElement | long","optional":true}
    ]
    bind_operation :remove, return_type: 'undefined', args: [
      {"name":"index","type":"long","optional":false}
    ]
  end

  class DOMStringList < Prism::Binding
    include Prism::BindingHelpers

    bind_attr_reader :length, return_type: 'unsigned long'

    bind_operation :item, return_type: 'DOMString', args: [
      {"name":"index","type":"unsigned long","optional":false}
    ]
    bind_operation :contains, return_type: 'boolean', args: [
      {"name":"string","type":"DOMString","optional":false}
    ]
  end

  # Skipped definition, name=DocumentReadyState, type='enum':
  # {
  #   "type": "enum",
  #   "name": "DocumentReadyState",
  #   "values": [
  #     {
  #       "type": "enum-value",
  #       "value": "loading"
  #     },
  #     {
  #       "type": "enum-value",
  #       "value": "interactive"
  #     },
  #     {
  #       "type": "enum-value",
  #       "value": "complete"
  #     }
  #   ],
  #   "extAttrs": []
  # }

  HTMLOrSVGScriptElement = TypeDef.new("HTMLOrSVGScriptElement", types: ["HTMLScriptElement","SVGScriptElement"])

  class Document
    include Prism::BindingHelpers

    bind_attr_reader :location, return_type: 'Location'
    bind_attr_reader :referrer, return_type: 'USVString'
    bind_attr_reader :lastModified, return_type: 'DOMString'
    bind_attr_reader :readyState, return_type: 'DocumentReadyState'
    bind_attr_reader :head, return_type: 'HTMLHeadElement'
    bind_attr_reader :images, return_type: 'HTMLCollection'
    bind_attr_reader :embeds, return_type: 'HTMLCollection'
    bind_attr_reader :plugins, return_type: 'HTMLCollection'
    bind_attr_reader :links, return_type: 'HTMLCollection'
    bind_attr_reader :forms, return_type: 'HTMLCollection'
    bind_attr_reader :scripts, return_type: 'HTMLCollection'
    bind_attr_reader :currentScript, return_type: 'HTMLOrSVGScriptElement'
    bind_attr_reader :defaultView, return_type: 'WindowProxy'

    bind_attr_accessor :domain, return_type: 'USVString'
    bind_attr_accessor :cookie, return_type: 'USVString'
    bind_attr_accessor :title, return_type: 'DOMString'
    bind_attr_accessor :dir, return_type: 'DOMString'
    bind_attr_accessor :body, return_type: 'HTMLElement'
    bind_attr_accessor :designMode, return_type: 'DOMString'
    bind_attr_accessor :onreadystatechange, return_type: 'EventHandler'

    bind_operation :[], return_type: 'object', args: [
      {"name":"name","type":"DOMString","optional":false}
    ]
    bind_operation :getElementsByName, return_type: 'NodeList', args: [
      {"name":"elementName","type":"DOMString","optional":false}
    ]
    bind_operation :open, return_type: 'Document', args: [
      {"name":"unused1","type":"DOMString","optional":true},
      {"name":"unused2","type":"DOMString","optional":true}
    ]
    bind_operation :open, return_type: 'WindowProxy', args: [
      {"name":"url","type":"USVString","optional":false},
      {"name":"name","type":"DOMString","optional":false},
      {"name":"features","type":"DOMString","optional":false}
    ]
    bind_operation :close, return_type: 'undefined', args: []
    bind_operation :write, return_type: 'undefined', args: [
      {"name":"text","type":"DOMString","optional":false}
    ]
    bind_operation :writeln, return_type: 'undefined', args: [
      {"name":"text","type":"DOMString","optional":false}
    ]
    bind_operation :hasFocus, return_type: 'boolean', args: []
    bind_operation :execCommand, return_type: 'boolean', args: [
      {"name":"commandId","type":"DOMString","optional":false},
      {"name":"showUI","type":"boolean","optional":true},
      {"name":"value","type":"DOMString","optional":true}
    ]
    bind_operation :queryCommandEnabled, return_type: 'boolean', args: [
      {"name":"commandId","type":"DOMString","optional":false}
    ]
    bind_operation :queryCommandIndeterm, return_type: 'boolean', args: [
      {"name":"commandId","type":"DOMString","optional":false}
    ]
    bind_operation :queryCommandState, return_type: 'boolean', args: [
      {"name":"commandId","type":"DOMString","optional":false}
    ]
    bind_operation :queryCommandSupported, return_type: 'boolean', args: [
      {"name":"commandId","type":"DOMString","optional":false}
    ]
    bind_operation :queryCommandValue, return_type: 'DOMString', args: [
      {"name":"commandId","type":"DOMString","optional":false}
    ]
  end

  module DocumentOrShadowRoot
    include Prism::BindingHelpers

    bind_attr_reader :activeElement, return_type: 'Element'
  end

  class HTMLElement < Element
    include Prism::BindingHelpers

    # def initialize()
    # end

    bind_attr_reader :accessKeyLabel, return_type: 'DOMString'

    bind_attr_accessor :title, return_type: 'DOMString'
    bind_attr_accessor :lang, return_type: 'DOMString'
    bind_attr_accessor :translate, return_type: 'boolean'
    bind_attr_accessor :dir, return_type: 'DOMString'
    bind_attr_accessor :hidden, return_type: 'boolean'
    bind_attr_accessor :accessKey, return_type: 'DOMString'
    bind_attr_accessor :draggable, return_type: 'boolean'
    bind_attr_accessor :spellcheck, return_type: 'boolean'
    bind_attr_accessor :autocapitalize, return_type: 'DOMString'
    bind_attr_accessor :innerText, return_type: 'DOMString'
    bind_attr_accessor :outerText, return_type: 'DOMString'

    bind_operation :click, return_type: 'undefined', args: []
    bind_operation :attachInternals, return_type: 'ElementInternals', args: []
  end

  class HTMLUnknownElement < HTMLElement
    include Prism::BindingHelpers


  end

  module HTMLOrSVGElement
    include Prism::BindingHelpers

    bind_attr_reader :dataset, return_type: 'DOMStringMap'

    bind_attr_accessor :nonce, return_type: 'DOMString'
    bind_attr_accessor :autofocus, return_type: 'boolean'
    bind_attr_accessor :tabIndex, return_type: 'long'

    bind_operation :focus, return_type: 'undefined', args: [
      {"name":"options","type":"FocusOptions","optional":true}
    ]
    bind_operation :blur, return_type: 'undefined', args: []
  end

  class DOMStringMap < Prism::Binding
    include Prism::BindingHelpers

    bind_operation :[], return_type: 'DOMString', args: [
      {"name":"name","type":"DOMString","optional":false}
    ]
    bind_operation :[]=, return_type: 'undefined', args: [
      {"name":"name","type":"DOMString","optional":false},
      {"name":"value","type":"DOMString","optional":false}
    ]
    bind_operation :_delete, return_type: 'undefined', args: [
      {"name":"name","type":"DOMString","optional":false}
    ]
  end

  class HTMLHtmlElement < HTMLElement
    include Prism::BindingHelpers

    # def initialize()
    # end
  end

  class HTMLHeadElement < HTMLElement
    include Prism::BindingHelpers

    # def initialize()
    # end
  end

  class HTMLTitleElement < HTMLElement
    include Prism::BindingHelpers

    # def initialize()
    # end

    bind_attr_accessor :text, return_type: 'DOMString'
  end

  class HTMLBaseElement < HTMLElement
    include Prism::BindingHelpers

    # def initialize()
    # end

    bind_attr_accessor :href, return_type: 'USVString'
    bind_attr_accessor :target, return_type: 'DOMString'
  end

  class HTMLLinkElement < HTMLElement
    include Prism::BindingHelpers

    # def initialize()
    # end

    bind_attr_reader :relList, return_type: 'DOMTokenList'
    bind_attr_reader :sizes, return_type: 'DOMTokenList'

    bind_attr_accessor :href, return_type: 'USVString'
    bind_attr_accessor :crossOrigin, return_type: 'DOMString'
    bind_attr_accessor :rel, return_type: 'DOMString'
    bind_attr_accessor :as, return_type: 'DOMString'
    bind_attr_accessor :media, return_type: 'DOMString'
    bind_attr_accessor :integrity, return_type: 'DOMString'
    bind_attr_accessor :hreflang, return_type: 'DOMString'
    bind_attr_accessor :type, return_type: 'DOMString'
    bind_attr_accessor :imageSrcset, return_type: 'USVString'
    bind_attr_accessor :imageSizes, return_type: 'DOMString'
    bind_attr_accessor :referrerPolicy, return_type: 'DOMString'
    bind_attr_accessor :disabled, return_type: 'boolean'
  end

  class HTMLMetaElement < HTMLElement
    include Prism::BindingHelpers

    # def initialize()
    # end

    bind_attr_accessor :name, return_type: 'DOMString'
    bind_attr_accessor :httpEquiv, return_type: 'DOMString'
    bind_attr_accessor :content, return_type: 'DOMString'
    bind_attr_accessor :media, return_type: 'DOMString'
  end

  class HTMLStyleElement < HTMLElement
    include Prism::BindingHelpers

    # def initialize()
    # end

    bind_attr_accessor :media, return_type: 'DOMString'
  end

  class HTMLBodyElement < HTMLElement
    include Prism::BindingHelpers

    # def initialize()
    # end
  end

  class HTMLHeadingElement < HTMLElement
    include Prism::BindingHelpers

    # def initialize()
    # end
  end

  class HTMLParagraphElement < HTMLElement
    include Prism::BindingHelpers

    # def initialize()
    # end
  end

  class HTMLHRElement < HTMLElement
    include Prism::BindingHelpers

    # def initialize()
    # end
  end

  class HTMLPreElement < HTMLElement
    include Prism::BindingHelpers

    # def initialize()
    # end
  end

  class HTMLQuoteElement < HTMLElement
    include Prism::BindingHelpers

    # def initialize()
    # end

    bind_attr_accessor :cite, return_type: 'USVString'
  end

  class HTMLOListElement < HTMLElement
    include Prism::BindingHelpers

    # def initialize()
    # end

    bind_attr_accessor :reversed, return_type: 'boolean'
    bind_attr_accessor :start, return_type: 'long'
    bind_attr_accessor :type, return_type: 'DOMString'
  end

  class HTMLUListElement < HTMLElement
    include Prism::BindingHelpers

    # def initialize()
    # end
  end

  class HTMLMenuElement < HTMLElement
    include Prism::BindingHelpers

    # def initialize()
    # end
  end

  class HTMLLIElement < HTMLElement
    include Prism::BindingHelpers

    # def initialize()
    # end

    bind_attr_accessor :value, return_type: 'long'
  end

  class HTMLDListElement < HTMLElement
    include Prism::BindingHelpers

    # def initialize()
    # end
  end

  class HTMLDivElement < HTMLElement
    include Prism::BindingHelpers

    # def initialize()
    # end
  end

  class HTMLAnchorElement < HTMLElement
    include Prism::BindingHelpers

    # def initialize()
    # end

    bind_attr_reader :relList, return_type: 'DOMTokenList'

    bind_attr_accessor :target, return_type: 'DOMString'
    bind_attr_accessor :download, return_type: 'DOMString'
    bind_attr_accessor :ping, return_type: 'USVString'
    bind_attr_accessor :rel, return_type: 'DOMString'
    bind_attr_accessor :hreflang, return_type: 'DOMString'
    bind_attr_accessor :type, return_type: 'DOMString'
    bind_attr_accessor :text, return_type: 'DOMString'
    bind_attr_accessor :referrerPolicy, return_type: 'DOMString'
  end

  class HTMLDataElement < HTMLElement
    include Prism::BindingHelpers

    # def initialize()
    # end

    bind_attr_accessor :value, return_type: 'DOMString'
  end

  class HTMLTimeElement < HTMLElement
    include Prism::BindingHelpers

    # def initialize()
    # end

    bind_attr_accessor :dateTime, return_type: 'DOMString'
  end

  class HTMLSpanElement < HTMLElement
    include Prism::BindingHelpers

    # def initialize()
    # end
  end

  class HTMLBRElement < HTMLElement
    include Prism::BindingHelpers

    # def initialize()
    # end
  end

  module HTMLHyperlinkElementUtils
    include Prism::BindingHelpers

    bind_attr_reader :origin, return_type: 'USVString'

    bind_attr_accessor :href, return_type: 'DOMString'
    bind_attr_accessor :protocol, return_type: 'USVString'
    bind_attr_accessor :username, return_type: 'USVString'
    bind_attr_accessor :password, return_type: 'USVString'
    bind_attr_accessor :host, return_type: 'USVString'
    bind_attr_accessor :hostname, return_type: 'USVString'
    bind_attr_accessor :port, return_type: 'USVString'
    bind_attr_accessor :pathname, return_type: 'USVString'
    bind_attr_accessor :search, return_type: 'USVString'
    bind_attr_accessor :hash, return_type: 'USVString'
  end

  class HTMLModElement < HTMLElement
    include Prism::BindingHelpers

    # def initialize()
    # end

    bind_attr_accessor :cite, return_type: 'USVString'
    bind_attr_accessor :dateTime, return_type: 'DOMString'
  end

  class HTMLPictureElement < HTMLElement
    include Prism::BindingHelpers

    # def initialize()
    # end
  end

  class HTMLSourceElement < HTMLElement
    include Prism::BindingHelpers

    # def initialize()
    # end

    bind_attr_accessor :src, return_type: 'USVString'
    bind_attr_accessor :type, return_type: 'DOMString'
    bind_attr_accessor :srcset, return_type: 'USVString'
    bind_attr_accessor :sizes, return_type: 'DOMString'
    bind_attr_accessor :media, return_type: 'DOMString'
    bind_attr_accessor :width, return_type: 'unsigned long'
    bind_attr_accessor :height, return_type: 'unsigned long'
  end

  class HTMLImageElement < HTMLElement
    include Prism::BindingHelpers

    # def initialize()
    # end

    bind_attr_reader :naturalWidth, return_type: 'unsigned long'
    bind_attr_reader :naturalHeight, return_type: 'unsigned long'
    bind_attr_reader :complete, return_type: 'boolean'
    bind_attr_reader :currentSrc, return_type: 'USVString'

    bind_attr_accessor :alt, return_type: 'DOMString'
    bind_attr_accessor :src, return_type: 'USVString'
    bind_attr_accessor :srcset, return_type: 'USVString'
    bind_attr_accessor :sizes, return_type: 'DOMString'
    bind_attr_accessor :crossOrigin, return_type: 'DOMString'
    bind_attr_accessor :useMap, return_type: 'DOMString'
    bind_attr_accessor :isMap, return_type: 'boolean'
    bind_attr_accessor :width, return_type: 'unsigned long'
    bind_attr_accessor :height, return_type: 'unsigned long'
    bind_attr_accessor :referrerPolicy, return_type: 'DOMString'
    bind_attr_accessor :decoding, return_type: 'DOMString'
    bind_attr_accessor :loading, return_type: 'DOMString'

    bind_operation :decode, return_type: 'undefined', args: []
  end

  class HTMLIFrameElement < HTMLElement
    include Prism::BindingHelpers

    # def initialize()
    # end

    bind_attr_reader :sandbox, return_type: 'DOMTokenList'
    bind_attr_reader :contentDocument, return_type: 'Document'
    bind_attr_reader :contentWindow, return_type: 'WindowProxy'

    bind_attr_accessor :src, return_type: 'USVString'
    bind_attr_accessor :srcdoc, return_type: 'DOMString'
    bind_attr_accessor :name, return_type: 'DOMString'
    bind_attr_accessor :allow, return_type: 'DOMString'
    bind_attr_accessor :allowFullscreen, return_type: 'boolean'
    bind_attr_accessor :width, return_type: 'DOMString'
    bind_attr_accessor :height, return_type: 'DOMString'
    bind_attr_accessor :referrerPolicy, return_type: 'DOMString'
    bind_attr_accessor :loading, return_type: 'DOMString'

    bind_operation :getSVGDocument, return_type: 'Document', args: []
  end

  class HTMLEmbedElement < HTMLElement
    include Prism::BindingHelpers

    # def initialize()
    # end

    bind_attr_accessor :src, return_type: 'USVString'
    bind_attr_accessor :type, return_type: 'DOMString'
    bind_attr_accessor :width, return_type: 'DOMString'
    bind_attr_accessor :height, return_type: 'DOMString'

    bind_operation :getSVGDocument, return_type: 'Document', args: []
  end

  class HTMLObjectElement < HTMLElement
    include Prism::BindingHelpers

    # def initialize()
    # end

    bind_attr_reader :form, return_type: 'HTMLFormElement'
    bind_attr_reader :contentDocument, return_type: 'Document'
    bind_attr_reader :contentWindow, return_type: 'WindowProxy'
    bind_attr_reader :willValidate, return_type: 'boolean'
    bind_attr_reader :validity, return_type: 'ValidityState'
    bind_attr_reader :validationMessage, return_type: 'DOMString'

    bind_attr_accessor :data, return_type: 'USVString'
    bind_attr_accessor :type, return_type: 'DOMString'
    bind_attr_accessor :name, return_type: 'DOMString'
    bind_attr_accessor :width, return_type: 'DOMString'
    bind_attr_accessor :height, return_type: 'DOMString'

    bind_operation :getSVGDocument, return_type: 'Document', args: []
    bind_operation :checkValidity, return_type: 'boolean', args: []
    bind_operation :reportValidity, return_type: 'boolean', args: []
    bind_operation :setCustomValidity, return_type: 'undefined', args: [
      {"name":"error","type":"DOMString","optional":false}
    ]
  end

  class HTMLParamElement < HTMLElement
    include Prism::BindingHelpers

    # def initialize()
    # end

    bind_attr_accessor :name, return_type: 'DOMString'
    bind_attr_accessor :value, return_type: 'DOMString'
  end

  class HTMLTrackElement < HTMLElement
    include Prism::BindingHelpers

    # def initialize()
    # end

    NONE = 0
    LOADING = 1
    LOADED = 2
    ERROR = 3

    bind_attr_reader :readyState, return_type: 'unsigned short'
    bind_attr_reader :track, return_type: 'TextTrack'

    bind_attr_accessor :kind, return_type: 'DOMString'
    bind_attr_accessor :src, return_type: 'USVString'
    bind_attr_accessor :srclang, return_type: 'DOMString'
    bind_attr_accessor :label, return_type: 'DOMString'
    bind_attr_accessor :default, return_type: 'boolean'
  end

  # Skipped definition, name=CanPlayTypeResult, type='enum':
  # {
  #   "type": "enum",
  #   "name": "CanPlayTypeResult",
  #   "values": [
  #     {
  #       "type": "enum-value",
  #       "value": ""
  #     },
  #     {
  #       "type": "enum-value",
  #       "value": "maybe"
  #     },
  #     {
  #       "type": "enum-value",
  #       "value": "probably"
  #     }
  #   ],
  #   "extAttrs": []
  # }

  MediaProvider = TypeDef.new("MediaProvider", types: ["MediaStream","MediaSource","Blob"])

  class HTMLMediaElement < HTMLElement
    include Prism::BindingHelpers

    NETWORK_EMPTY = 0
    NETWORK_IDLE = 1
    NETWORK_LOADING = 2
    NETWORK_NO_SOURCE = 3
    HAVE_NOTHING = 0
    HAVE_METADATA = 1
    HAVE_CURRENT_DATA = 2
    HAVE_FUTURE_DATA = 3
    HAVE_ENOUGH_DATA = 4

    bind_attr_reader :error, return_type: 'MediaError'
    bind_attr_reader :currentSrc, return_type: 'USVString'
    bind_attr_reader :networkState, return_type: 'unsigned short'
    bind_attr_reader :buffered, return_type: 'TimeRanges'
    bind_attr_reader :readyState, return_type: 'unsigned short'
    bind_attr_reader :seeking, return_type: 'boolean'
    bind_attr_reader :duration, return_type: 'unrestricted double'
    bind_attr_reader :paused, return_type: 'boolean'
    bind_attr_reader :played, return_type: 'TimeRanges'
    bind_attr_reader :seekable, return_type: 'TimeRanges'
    bind_attr_reader :ended, return_type: 'boolean'
    bind_attr_reader :audioTracks, return_type: 'AudioTrackList'
    bind_attr_reader :videoTracks, return_type: 'VideoTrackList'
    bind_attr_reader :textTracks, return_type: 'TextTrackList'

    bind_attr_accessor :src, return_type: 'USVString'
    bind_attr_accessor :srcObject, return_type: 'MediaProvider'
    bind_attr_accessor :crossOrigin, return_type: 'DOMString'
    bind_attr_accessor :preload, return_type: 'DOMString'
    bind_attr_accessor :currentTime, return_type: 'double'
    bind_attr_accessor :defaultPlaybackRate, return_type: 'double'
    bind_attr_accessor :playbackRate, return_type: 'double'
    bind_attr_accessor :preservesPitch, return_type: 'boolean'
    bind_attr_accessor :autoplay, return_type: 'boolean'
    bind_attr_accessor :loop, return_type: 'boolean'
    bind_attr_accessor :controls, return_type: 'boolean'
    bind_attr_accessor :volume, return_type: 'double'
    bind_attr_accessor :muted, return_type: 'boolean'
    bind_attr_accessor :defaultMuted, return_type: 'boolean'

    bind_operation :load, return_type: 'undefined', args: []
    bind_operation :canPlayType, return_type: 'CanPlayTypeResult', args: [
      {"name":"type","type":"DOMString","optional":false}
    ]
    bind_operation :fastSeek, return_type: 'undefined', args: [
      {"name":"time","type":"double","optional":false}
    ]
    bind_operation :getStartDate, return_type: 'object', args: []
    bind_operation :play, return_type: 'undefined', args: []
    bind_operation :pause, return_type: 'undefined', args: []
    bind_operation :addTextTrack, return_type: 'TextTrack', args: [
      {"name":"kind","type":"TextTrackKind","optional":false},
      {"name":"label","type":"DOMString","optional":true},
      {"name":"language","type":"DOMString","optional":true}
    ]
  end

  class HTMLVideoElement < HTMLMediaElement
    include Prism::BindingHelpers

    # def initialize()
    # end

    bind_attr_reader :videoWidth, return_type: 'unsigned long'
    bind_attr_reader :videoHeight, return_type: 'unsigned long'

    bind_attr_accessor :width, return_type: 'unsigned long'
    bind_attr_accessor :height, return_type: 'unsigned long'
    bind_attr_accessor :poster, return_type: 'USVString'
    bind_attr_accessor :playsInline, return_type: 'boolean'
  end

  class HTMLAudioElement < HTMLMediaElement
    include Prism::BindingHelpers

    # def initialize()
    # end
  end

  class MediaError < Prism::Binding
    include Prism::BindingHelpers

    MEDIA_ERR_ABORTED = 1
    MEDIA_ERR_NETWORK = 2
    MEDIA_ERR_DECODE = 3
    MEDIA_ERR_SRC_NOT_SUPPORTED = 4

    bind_attr_reader :code, return_type: 'unsigned short'
    bind_attr_reader :message, return_type: 'DOMString'
  end

  class AudioTrackList < EventTarget
    include Prism::BindingHelpers

    bind_attr_reader :length, return_type: 'unsigned long'

    bind_attr_accessor :onchange, return_type: 'EventHandler'
    bind_attr_accessor :onaddtrack, return_type: 'EventHandler'
    bind_attr_accessor :onremovetrack, return_type: 'EventHandler'

    bind_operation :[], return_type: 'AudioTrack', args: [
      {"name":"index","type":"unsigned long","optional":false}
    ]
    bind_operation :getTrackById, return_type: 'AudioTrack', args: [
      {"name":"id","type":"DOMString","optional":false}
    ]
  end

  class AudioTrack < Prism::Binding
    include Prism::BindingHelpers

    bind_attr_reader :id, return_type: 'DOMString'
    bind_attr_reader :kind, return_type: 'DOMString'
    bind_attr_reader :label, return_type: 'DOMString'
    bind_attr_reader :language, return_type: 'DOMString'

    bind_attr_accessor :enabled, return_type: 'boolean'
  end

  class VideoTrackList < EventTarget
    include Prism::BindingHelpers

    bind_attr_reader :length, return_type: 'unsigned long'
    bind_attr_reader :selectedIndex, return_type: 'long'

    bind_attr_accessor :onchange, return_type: 'EventHandler'
    bind_attr_accessor :onaddtrack, return_type: 'EventHandler'
    bind_attr_accessor :onremovetrack, return_type: 'EventHandler'

    bind_operation :[], return_type: 'VideoTrack', args: [
      {"name":"index","type":"unsigned long","optional":false}
    ]
    bind_operation :getTrackById, return_type: 'VideoTrack', args: [
      {"name":"id","type":"DOMString","optional":false}
    ]
  end

  class VideoTrack < Prism::Binding
    include Prism::BindingHelpers

    bind_attr_reader :id, return_type: 'DOMString'
    bind_attr_reader :kind, return_type: 'DOMString'
    bind_attr_reader :label, return_type: 'DOMString'
    bind_attr_reader :language, return_type: 'DOMString'

    bind_attr_accessor :selected, return_type: 'boolean'
  end

  class TextTrackList < EventTarget
    include Prism::BindingHelpers

    bind_attr_reader :length, return_type: 'unsigned long'

    bind_attr_accessor :onchange, return_type: 'EventHandler'
    bind_attr_accessor :onaddtrack, return_type: 'EventHandler'
    bind_attr_accessor :onremovetrack, return_type: 'EventHandler'

    bind_operation :[], return_type: 'TextTrack', args: [
      {"name":"index","type":"unsigned long","optional":false}
    ]
    bind_operation :getTrackById, return_type: 'TextTrack', args: [
      {"name":"id","type":"DOMString","optional":false}
    ]
  end

  # Skipped definition, name=TextTrackMode, type='enum':
  # {
  #   "type": "enum",
  #   "name": "TextTrackMode",
  #   "values": [
  #     {
  #       "type": "enum-value",
  #       "value": "disabled"
  #     },
  #     {
  #       "type": "enum-value",
  #       "value": "hidden"
  #     },
  #     {
  #       "type": "enum-value",
  #       "value": "showing"
  #     }
  #   ],
  #   "extAttrs": []
  # }

  # Skipped definition, name=TextTrackKind, type='enum':
  # {
  #   "type": "enum",
  #   "name": "TextTrackKind",
  #   "values": [
  #     {
  #       "type": "enum-value",
  #       "value": "subtitles"
  #     },
  #     {
  #       "type": "enum-value",
  #       "value": "captions"
  #     },
  #     {
  #       "type": "enum-value",
  #       "value": "descriptions"
  #     },
  #     {
  #       "type": "enum-value",
  #       "value": "chapters"
  #     },
  #     {
  #       "type": "enum-value",
  #       "value": "metadata"
  #     }
  #   ],
  #   "extAttrs": []
  # }

  class TextTrack < EventTarget
    include Prism::BindingHelpers

    bind_attr_reader :kind, return_type: 'TextTrackKind'
    bind_attr_reader :label, return_type: 'DOMString'
    bind_attr_reader :language, return_type: 'DOMString'
    bind_attr_reader :id, return_type: 'DOMString'
    bind_attr_reader :inBandMetadataTrackDispatchType, return_type: 'DOMString'
    bind_attr_reader :cues, return_type: 'TextTrackCueList'
    bind_attr_reader :activeCues, return_type: 'TextTrackCueList'

    bind_attr_accessor :mode, return_type: 'TextTrackMode'
    bind_attr_accessor :oncuechange, return_type: 'EventHandler'

    bind_operation :addCue, return_type: 'undefined', args: [
      {"name":"cue","type":"TextTrackCue","optional":false}
    ]
    bind_operation :removeCue, return_type: 'undefined', args: [
      {"name":"cue","type":"TextTrackCue","optional":false}
    ]
  end

  class TextTrackCueList < Prism::Binding
    include Prism::BindingHelpers

    bind_attr_reader :length, return_type: 'unsigned long'

    bind_operation :[], return_type: 'TextTrackCue', args: [
      {"name":"index","type":"unsigned long","optional":false}
    ]
    bind_operation :getCueById, return_type: 'TextTrackCue', args: [
      {"name":"id","type":"DOMString","optional":false}
    ]
  end

  class TextTrackCue < EventTarget
    include Prism::BindingHelpers

    bind_attr_reader :track, return_type: 'TextTrack'

    bind_attr_accessor :id, return_type: 'DOMString'
    bind_attr_accessor :startTime, return_type: 'double'
    bind_attr_accessor :endTime, return_type: 'unrestricted double'
    bind_attr_accessor :pauseOnExit, return_type: 'boolean'
    bind_attr_accessor :onenter, return_type: 'EventHandler'
    bind_attr_accessor :onexit, return_type: 'EventHandler'
  end

  class TimeRanges < Prism::Binding
    include Prism::BindingHelpers

    bind_attr_reader :length, return_type: 'unsigned long'

    bind_operation :start, return_type: 'double', args: [
      {"name":"index","type":"unsigned long","optional":false}
    ]
    bind_operation :end, return_type: 'double', args: [
      {"name":"index","type":"unsigned long","optional":false}
    ]
  end

  class TrackEvent < Event
    include Prism::BindingHelpers

    # def initialize(type, eventInitDict = UNDEFINED)
    # end

    bind_attr_reader :track, return_type: 'VideoTrack | AudioTrack | TextTrack'
  end

  # Skipped definition, name=TrackEventInit, type='dictionary':
  # {
  #   "type": "dictionary",
  #   "name": "TrackEventInit",
  #   "inheritance": "EventInit",
  #   "members": [
  #     {
  #       "type": "field",
  #       "name": "track",
  #       "extAttrs": [],
  #       "idlType": {
  #         "type": "dictionary-type",
  #         "extAttrs": [],
  #         "generic": "",
  #         "nullable": true,
  #         "union": true,
  #         "idlType": [
  #           {
  #             "type": null,
  #             "extAttrs": [],
  #             "generic": "",
  #             "nullable": false,
  #             "union": false,
  #             "idlType": "VideoTrack"
  #           },
  #           {
  #             "type": null,
  #             "extAttrs": [],
  #             "generic": "",
  #             "nullable": false,
  #             "union": false,
  #             "idlType": "AudioTrack"
  #           },
  #           {
  #             "type": null,
  #             "extAttrs": [],
  #             "generic": "",
  #             "nullable": false,
  #             "union": false,
  #             "idlType": "TextTrack"
  #           }
  #         ]
  #       },
  #       "default": {
  #         "type": "null"
  #       },
  #       "required": false
  #     }
  #   ],
  #   "extAttrs": [],
  #   "partial": false
  # }

  class HTMLMapElement < HTMLElement
    include Prism::BindingHelpers

    # def initialize()
    # end

    bind_attr_reader :areas, return_type: 'HTMLCollection'

    bind_attr_accessor :name, return_type: 'DOMString'
  end

  class HTMLAreaElement < HTMLElement
    include Prism::BindingHelpers

    # def initialize()
    # end

    bind_attr_reader :relList, return_type: 'DOMTokenList'

    bind_attr_accessor :alt, return_type: 'DOMString'
    bind_attr_accessor :coords, return_type: 'DOMString'
    bind_attr_accessor :shape, return_type: 'DOMString'
    bind_attr_accessor :target, return_type: 'DOMString'
    bind_attr_accessor :download, return_type: 'DOMString'
    bind_attr_accessor :ping, return_type: 'USVString'
    bind_attr_accessor :rel, return_type: 'DOMString'
    bind_attr_accessor :referrerPolicy, return_type: 'DOMString'
  end

  class HTMLTableElement < HTMLElement
    include Prism::BindingHelpers

    # def initialize()
    # end

    bind_attr_reader :tBodies, return_type: 'HTMLCollection'
    bind_attr_reader :rows, return_type: 'HTMLCollection'

    bind_attr_accessor :caption, return_type: 'HTMLTableCaptionElement'
    bind_attr_accessor :tHead, return_type: 'HTMLTableSectionElement'
    bind_attr_accessor :tFoot, return_type: 'HTMLTableSectionElement'

    bind_operation :createCaption, return_type: 'HTMLTableCaptionElement', args: []
    bind_operation :deleteCaption, return_type: 'undefined', args: []
    bind_operation :createTHead, return_type: 'HTMLTableSectionElement', args: []
    bind_operation :deleteTHead, return_type: 'undefined', args: []
    bind_operation :createTFoot, return_type: 'HTMLTableSectionElement', args: []
    bind_operation :deleteTFoot, return_type: 'undefined', args: []
    bind_operation :createTBody, return_type: 'HTMLTableSectionElement', args: []
    bind_operation :insertRow, return_type: 'HTMLTableRowElement', args: [
      {"name":"index","type":"long","optional":true}
    ]
    bind_operation :deleteRow, return_type: 'undefined', args: [
      {"name":"index","type":"long","optional":false}
    ]
  end

  class HTMLTableCaptionElement < HTMLElement
    include Prism::BindingHelpers

    # def initialize()
    # end
  end

  class HTMLTableColElement < HTMLElement
    include Prism::BindingHelpers

    # def initialize()
    # end

    bind_attr_accessor :span, return_type: 'unsigned long'
  end

  class HTMLTableSectionElement < HTMLElement
    include Prism::BindingHelpers

    # def initialize()
    # end

    bind_attr_reader :rows, return_type: 'HTMLCollection'

    bind_operation :insertRow, return_type: 'HTMLTableRowElement', args: [
      {"name":"index","type":"long","optional":true}
    ]
    bind_operation :deleteRow, return_type: 'undefined', args: [
      {"name":"index","type":"long","optional":false}
    ]
  end

  class HTMLTableRowElement < HTMLElement
    include Prism::BindingHelpers

    # def initialize()
    # end

    bind_attr_reader :rowIndex, return_type: 'long'
    bind_attr_reader :sectionRowIndex, return_type: 'long'
    bind_attr_reader :cells, return_type: 'HTMLCollection'

    bind_operation :insertCell, return_type: 'HTMLTableCellElement', args: [
      {"name":"index","type":"long","optional":true}
    ]
    bind_operation :deleteCell, return_type: 'undefined', args: [
      {"name":"index","type":"long","optional":false}
    ]
  end

  class HTMLTableCellElement < HTMLElement
    include Prism::BindingHelpers

    # def initialize()
    # end

    bind_attr_reader :cellIndex, return_type: 'long'

    bind_attr_accessor :colSpan, return_type: 'unsigned long'
    bind_attr_accessor :rowSpan, return_type: 'unsigned long'
    bind_attr_accessor :headers, return_type: 'DOMString'
    bind_attr_accessor :scope, return_type: 'DOMString'
    bind_attr_accessor :abbr, return_type: 'DOMString'
  end

  class HTMLFormElement < HTMLElement
    include Prism::BindingHelpers

    # def initialize()
    # end

    bind_attr_reader :relList, return_type: 'DOMTokenList'
    bind_attr_reader :elements, return_type: 'HTMLFormControlsCollection'
    bind_attr_reader :length, return_type: 'unsigned long'

    bind_attr_accessor :acceptCharset, return_type: 'DOMString'
    bind_attr_accessor :action, return_type: 'USVString'
    bind_attr_accessor :autocomplete, return_type: 'DOMString'
    bind_attr_accessor :enctype, return_type: 'DOMString'
    bind_attr_accessor :encoding, return_type: 'DOMString'
    bind_attr_accessor :method, return_type: 'DOMString'
    bind_attr_accessor :name, return_type: 'DOMString'
    bind_attr_accessor :noValidate, return_type: 'boolean'
    bind_attr_accessor :target, return_type: 'DOMString'
    bind_attr_accessor :rel, return_type: 'DOMString'

    bind_operation :[], return_type: 'Element', args: [
      {"name":"index","type":"unsigned long","optional":false}
    ]
    bind_operation :[], return_type: 'RadioNodeList | Element', args: [
      {"name":"name","type":"DOMString","optional":false}
    ]
    bind_operation :submit, return_type: 'undefined', args: []
    bind_operation :requestSubmit, return_type: 'undefined', args: [
      {"name":"submitter","type":"HTMLElement","optional":true}
    ]
    bind_operation :reset, return_type: 'undefined', args: []
    bind_operation :checkValidity, return_type: 'boolean', args: []
    bind_operation :reportValidity, return_type: 'boolean', args: []
  end

  class HTMLLabelElement < HTMLElement
    include Prism::BindingHelpers

    # def initialize()
    # end

    bind_attr_reader :form, return_type: 'HTMLFormElement'
    bind_attr_reader :control, return_type: 'HTMLElement'

    bind_attr_accessor :htmlFor, return_type: 'DOMString'
  end

  class HTMLInputElement < HTMLElement
    include Prism::BindingHelpers

    # def initialize()
    # end

    bind_attr_reader :form, return_type: 'HTMLFormElement'
    bind_attr_reader :list, return_type: 'HTMLElement'
    bind_attr_reader :willValidate, return_type: 'boolean'
    bind_attr_reader :validity, return_type: 'ValidityState'
    bind_attr_reader :validationMessage, return_type: 'DOMString'
    bind_attr_reader :labels, return_type: 'NodeList'

    bind_attr_accessor :accept, return_type: 'DOMString'
    bind_attr_accessor :alt, return_type: 'DOMString'
    bind_attr_accessor :autocomplete, return_type: 'DOMString'
    bind_attr_accessor :defaultChecked, return_type: 'boolean'
    bind_attr_accessor :checked, return_type: 'boolean'
    bind_attr_accessor :dirName, return_type: 'DOMString'
    bind_attr_accessor :disabled, return_type: 'boolean'
    bind_attr_accessor :files, return_type: 'FileList'
    bind_attr_accessor :formAction, return_type: 'USVString'
    bind_attr_accessor :formEnctype, return_type: 'DOMString'
    bind_attr_accessor :formMethod, return_type: 'DOMString'
    bind_attr_accessor :formNoValidate, return_type: 'boolean'
    bind_attr_accessor :formTarget, return_type: 'DOMString'
    bind_attr_accessor :height, return_type: 'unsigned long'
    bind_attr_accessor :indeterminate, return_type: 'boolean'
    bind_attr_accessor :max, return_type: 'DOMString'
    bind_attr_accessor :maxLength, return_type: 'long'
    bind_attr_accessor :min, return_type: 'DOMString'
    bind_attr_accessor :minLength, return_type: 'long'
    bind_attr_accessor :multiple, return_type: 'boolean'
    bind_attr_accessor :name, return_type: 'DOMString'
    bind_attr_accessor :pattern, return_type: 'DOMString'
    bind_attr_accessor :placeholder, return_type: 'DOMString'
    bind_attr_accessor :readOnly, return_type: 'boolean'
    bind_attr_accessor :required, return_type: 'boolean'
    bind_attr_accessor :size, return_type: 'unsigned long'
    bind_attr_accessor :src, return_type: 'USVString'
    bind_attr_accessor :step, return_type: 'DOMString'
    bind_attr_accessor :type, return_type: 'DOMString'
    bind_attr_accessor :defaultValue, return_type: 'DOMString'
    bind_attr_accessor :value, return_type: 'DOMString'
    bind_attr_accessor :valueAsDate, return_type: 'object'
    bind_attr_accessor :valueAsNumber, return_type: 'unrestricted double'
    bind_attr_accessor :width, return_type: 'unsigned long'
    bind_attr_accessor :selectionStart, return_type: 'unsigned long'
    bind_attr_accessor :selectionEnd, return_type: 'unsigned long'
    bind_attr_accessor :selectionDirection, return_type: 'DOMString'

    bind_operation :stepUp, return_type: 'undefined', args: [
      {"name":"n","type":"long","optional":true}
    ]
    bind_operation :stepDown, return_type: 'undefined', args: [
      {"name":"n","type":"long","optional":true}
    ]
    bind_operation :checkValidity, return_type: 'boolean', args: []
    bind_operation :reportValidity, return_type: 'boolean', args: []
    bind_operation :setCustomValidity, return_type: 'undefined', args: [
      {"name":"error","type":"DOMString","optional":false}
    ]
    bind_operation :select, return_type: 'undefined', args: []
    bind_operation :setRangeText, return_type: 'undefined', args: [
      {"name":"replacement","type":"DOMString","optional":false}
    ]
    bind_operation :setRangeText, return_type: 'undefined', args: [
      {"name":"replacement","type":"DOMString","optional":false},
      {"name":"start","type":"unsigned long","optional":false},
      {"name":"end","type":"unsigned long","optional":false},
      {"name":"selectionMode","type":"SelectionMode","optional":true}
    ]
    bind_operation :setSelectionRange, return_type: 'undefined', args: [
      {"name":"start","type":"unsigned long","optional":false},
      {"name":"end","type":"unsigned long","optional":false},
      {"name":"direction","type":"DOMString","optional":true}
    ]
  end

  class HTMLButtonElement < HTMLElement
    include Prism::BindingHelpers

    # def initialize()
    # end

    bind_attr_reader :form, return_type: 'HTMLFormElement'
    bind_attr_reader :willValidate, return_type: 'boolean'
    bind_attr_reader :validity, return_type: 'ValidityState'
    bind_attr_reader :validationMessage, return_type: 'DOMString'
    bind_attr_reader :labels, return_type: 'NodeList'

    bind_attr_accessor :disabled, return_type: 'boolean'
    bind_attr_accessor :formAction, return_type: 'USVString'
    bind_attr_accessor :formEnctype, return_type: 'DOMString'
    bind_attr_accessor :formMethod, return_type: 'DOMString'
    bind_attr_accessor :formNoValidate, return_type: 'boolean'
    bind_attr_accessor :formTarget, return_type: 'DOMString'
    bind_attr_accessor :name, return_type: 'DOMString'
    bind_attr_accessor :type, return_type: 'DOMString'
    bind_attr_accessor :value, return_type: 'DOMString'

    bind_operation :checkValidity, return_type: 'boolean', args: []
    bind_operation :reportValidity, return_type: 'boolean', args: []
    bind_operation :setCustomValidity, return_type: 'undefined', args: [
      {"name":"error","type":"DOMString","optional":false}
    ]
  end

  class HTMLSelectElement < HTMLElement
    include Prism::BindingHelpers

    # def initialize()
    # end

    bind_attr_reader :form, return_type: 'HTMLFormElement'
    bind_attr_reader :type, return_type: 'DOMString'
    bind_attr_reader :options, return_type: 'HTMLOptionsCollection'
    bind_attr_reader :selectedOptions, return_type: 'HTMLCollection'
    bind_attr_reader :willValidate, return_type: 'boolean'
    bind_attr_reader :validity, return_type: 'ValidityState'
    bind_attr_reader :validationMessage, return_type: 'DOMString'
    bind_attr_reader :labels, return_type: 'NodeList'

    bind_attr_accessor :autocomplete, return_type: 'DOMString'
    bind_attr_accessor :disabled, return_type: 'boolean'
    bind_attr_accessor :multiple, return_type: 'boolean'
    bind_attr_accessor :name, return_type: 'DOMString'
    bind_attr_accessor :required, return_type: 'boolean'
    bind_attr_accessor :size, return_type: 'unsigned long'
    bind_attr_accessor :length, return_type: 'unsigned long'
    bind_attr_accessor :selectedIndex, return_type: 'long'
    bind_attr_accessor :value, return_type: 'DOMString'

    bind_operation :item, return_type: 'HTMLOptionElement', args: [
      {"name":"index","type":"unsigned long","optional":false}
    ]
    bind_operation :namedItem, return_type: 'HTMLOptionElement', args: [
      {"name":"name","type":"DOMString","optional":false}
    ]
    bind_operation :add, return_type: 'undefined', args: [
      {"name":"element","type":"HTMLOptionElement | HTMLOptGroupElement","optional":false},
      {"name":"before","type":"HTMLElement | long","optional":true}
    ]
    bind_operation :remove, return_type: 'undefined', args: []
    bind_operation :remove, return_type: 'undefined', args: [
      {"name":"index","type":"long","optional":false}
    ]
    bind_operation :[]=, return_type: 'undefined', args: [
      {"name":"index","type":"unsigned long","optional":false},
      {"name":"option","type":"HTMLOptionElement","optional":false}
    ]
    bind_operation :checkValidity, return_type: 'boolean', args: []
    bind_operation :reportValidity, return_type: 'boolean', args: []
    bind_operation :setCustomValidity, return_type: 'undefined', args: [
      {"name":"error","type":"DOMString","optional":false}
    ]
  end

  class HTMLDataListElement < HTMLElement
    include Prism::BindingHelpers

    # def initialize()
    # end

    bind_attr_reader :options, return_type: 'HTMLCollection'
  end

  class HTMLOptGroupElement < HTMLElement
    include Prism::BindingHelpers

    # def initialize()
    # end

    bind_attr_accessor :disabled, return_type: 'boolean'
    bind_attr_accessor :label, return_type: 'DOMString'
  end

  class HTMLOptionElement < HTMLElement
    include Prism::BindingHelpers

    # def initialize()
    # end

    bind_attr_reader :form, return_type: 'HTMLFormElement'
    bind_attr_reader :index, return_type: 'long'

    bind_attr_accessor :disabled, return_type: 'boolean'
    bind_attr_accessor :label, return_type: 'DOMString'
    bind_attr_accessor :defaultSelected, return_type: 'boolean'
    bind_attr_accessor :selected, return_type: 'boolean'
    bind_attr_accessor :value, return_type: 'DOMString'
    bind_attr_accessor :text, return_type: 'DOMString'
  end

  class HTMLTextAreaElement < HTMLElement
    include Prism::BindingHelpers

    # def initialize()
    # end

    bind_attr_reader :form, return_type: 'HTMLFormElement'
    bind_attr_reader :type, return_type: 'DOMString'
    bind_attr_reader :textLength, return_type: 'unsigned long'
    bind_attr_reader :willValidate, return_type: 'boolean'
    bind_attr_reader :validity, return_type: 'ValidityState'
    bind_attr_reader :validationMessage, return_type: 'DOMString'
    bind_attr_reader :labels, return_type: 'NodeList'

    bind_attr_accessor :autocomplete, return_type: 'DOMString'
    bind_attr_accessor :cols, return_type: 'unsigned long'
    bind_attr_accessor :dirName, return_type: 'DOMString'
    bind_attr_accessor :disabled, return_type: 'boolean'
    bind_attr_accessor :maxLength, return_type: 'long'
    bind_attr_accessor :minLength, return_type: 'long'
    bind_attr_accessor :name, return_type: 'DOMString'
    bind_attr_accessor :placeholder, return_type: 'DOMString'
    bind_attr_accessor :readOnly, return_type: 'boolean'
    bind_attr_accessor :required, return_type: 'boolean'
    bind_attr_accessor :rows, return_type: 'unsigned long'
    bind_attr_accessor :wrap, return_type: 'DOMString'
    bind_attr_accessor :defaultValue, return_type: 'DOMString'
    bind_attr_accessor :value, return_type: 'DOMString'
    bind_attr_accessor :selectionStart, return_type: 'unsigned long'
    bind_attr_accessor :selectionEnd, return_type: 'unsigned long'
    bind_attr_accessor :selectionDirection, return_type: 'DOMString'

    bind_operation :checkValidity, return_type: 'boolean', args: []
    bind_operation :reportValidity, return_type: 'boolean', args: []
    bind_operation :setCustomValidity, return_type: 'undefined', args: [
      {"name":"error","type":"DOMString","optional":false}
    ]
    bind_operation :select, return_type: 'undefined', args: []
    bind_operation :setRangeText, return_type: 'undefined', args: [
      {"name":"replacement","type":"DOMString","optional":false}
    ]
    bind_operation :setRangeText, return_type: 'undefined', args: [
      {"name":"replacement","type":"DOMString","optional":false},
      {"name":"start","type":"unsigned long","optional":false},
      {"name":"end","type":"unsigned long","optional":false},
      {"name":"selectionMode","type":"SelectionMode","optional":true}
    ]
    bind_operation :setSelectionRange, return_type: 'undefined', args: [
      {"name":"start","type":"unsigned long","optional":false},
      {"name":"end","type":"unsigned long","optional":false},
      {"name":"direction","type":"DOMString","optional":true}
    ]
  end

  class HTMLOutputElement < HTMLElement
    include Prism::BindingHelpers

    # def initialize()
    # end

    bind_attr_reader :htmlFor, return_type: 'DOMTokenList'
    bind_attr_reader :form, return_type: 'HTMLFormElement'
    bind_attr_reader :type, return_type: 'DOMString'
    bind_attr_reader :willValidate, return_type: 'boolean'
    bind_attr_reader :validity, return_type: 'ValidityState'
    bind_attr_reader :validationMessage, return_type: 'DOMString'
    bind_attr_reader :labels, return_type: 'NodeList'

    bind_attr_accessor :name, return_type: 'DOMString'
    bind_attr_accessor :defaultValue, return_type: 'DOMString'
    bind_attr_accessor :value, return_type: 'DOMString'

    bind_operation :checkValidity, return_type: 'boolean', args: []
    bind_operation :reportValidity, return_type: 'boolean', args: []
    bind_operation :setCustomValidity, return_type: 'undefined', args: [
      {"name":"error","type":"DOMString","optional":false}
    ]
  end

  class HTMLProgressElement < HTMLElement
    include Prism::BindingHelpers

    # def initialize()
    # end

    bind_attr_reader :position, return_type: 'double'
    bind_attr_reader :labels, return_type: 'NodeList'

    bind_attr_accessor :value, return_type: 'double'
    bind_attr_accessor :max, return_type: 'double'
  end

  class HTMLMeterElement < HTMLElement
    include Prism::BindingHelpers

    # def initialize()
    # end

    bind_attr_reader :labels, return_type: 'NodeList'

    bind_attr_accessor :value, return_type: 'double'
    bind_attr_accessor :min, return_type: 'double'
    bind_attr_accessor :max, return_type: 'double'
    bind_attr_accessor :low, return_type: 'double'
    bind_attr_accessor :high, return_type: 'double'
    bind_attr_accessor :optimum, return_type: 'double'
  end

  class HTMLFieldSetElement < HTMLElement
    include Prism::BindingHelpers

    # def initialize()
    # end

    bind_attr_reader :form, return_type: 'HTMLFormElement'
    bind_attr_reader :type, return_type: 'DOMString'
    bind_attr_reader :elements, return_type: 'HTMLCollection'
    bind_attr_reader :willValidate, return_type: 'boolean'
    bind_attr_reader :validity, return_type: 'ValidityState'
    bind_attr_reader :validationMessage, return_type: 'DOMString'

    bind_attr_accessor :disabled, return_type: 'boolean'
    bind_attr_accessor :name, return_type: 'DOMString'

    bind_operation :checkValidity, return_type: 'boolean', args: []
    bind_operation :reportValidity, return_type: 'boolean', args: []
    bind_operation :setCustomValidity, return_type: 'undefined', args: [
      {"name":"error","type":"DOMString","optional":false}
    ]
  end

  class HTMLLegendElement < HTMLElement
    include Prism::BindingHelpers

    # def initialize()
    # end

    bind_attr_reader :form, return_type: 'HTMLFormElement'
  end

  # Skipped definition, name=SelectionMode, type='enum':
  # {
  #   "type": "enum",
  #   "name": "SelectionMode",
  #   "values": [
  #     {
  #       "type": "enum-value",
  #       "value": "select"
  #     },
  #     {
  #       "type": "enum-value",
  #       "value": "start"
  #     },
  #     {
  #       "type": "enum-value",
  #       "value": "end"
  #     },
  #     {
  #       "type": "enum-value",
  #       "value": "preserve"
  #     }
  #   ],
  #   "extAttrs": []
  # }

  class ValidityState < Prism::Binding
    include Prism::BindingHelpers

    bind_attr_reader :valueMissing, return_type: 'boolean'
    bind_attr_reader :typeMismatch, return_type: 'boolean'
    bind_attr_reader :patternMismatch, return_type: 'boolean'
    bind_attr_reader :tooLong, return_type: 'boolean'
    bind_attr_reader :tooShort, return_type: 'boolean'
    bind_attr_reader :rangeUnderflow, return_type: 'boolean'
    bind_attr_reader :rangeOverflow, return_type: 'boolean'
    bind_attr_reader :stepMismatch, return_type: 'boolean'
    bind_attr_reader :badInput, return_type: 'boolean'
    bind_attr_reader :customError, return_type: 'boolean'
    bind_attr_reader :valid, return_type: 'boolean'
  end

  class SubmitEvent < Event
    include Prism::BindingHelpers

    # def initialize(type, eventInitDict = UNDEFINED)
    # end

    bind_attr_reader :submitter, return_type: 'HTMLElement'
  end

  # Skipped definition, name=SubmitEventInit, type='dictionary':
  # {
  #   "type": "dictionary",
  #   "name": "SubmitEventInit",
  #   "inheritance": "EventInit",
  #   "members": [
  #     {
  #       "type": "field",
  #       "name": "submitter",
  #       "extAttrs": [],
  #       "idlType": {
  #         "type": "dictionary-type",
  #         "extAttrs": [],
  #         "generic": "",
  #         "nullable": true,
  #         "union": false,
  #         "idlType": "HTMLElement"
  #       },
  #       "default": {
  #         "type": "null"
  #       },
  #       "required": false
  #     }
  #   ],
  #   "extAttrs": [],
  #   "partial": false
  # }

  class FormDataEvent < Event
    include Prism::BindingHelpers

    # def initialize(type, eventInitDict)
    # end

    bind_attr_reader :formData, return_type: 'FormData'
  end

  # Skipped definition, name=FormDataEventInit, type='dictionary':
  # {
  #   "type": "dictionary",
  #   "name": "FormDataEventInit",
  #   "inheritance": "EventInit",
  #   "members": [
  #     {
  #       "type": "field",
  #       "name": "formData",
  #       "extAttrs": [],
  #       "idlType": {
  #         "type": "dictionary-type",
  #         "extAttrs": [],
  #         "generic": "",
  #         "nullable": false,
  #         "union": false,
  #         "idlType": "FormData"
  #       },
  #       "default": null,
  #       "required": true
  #     }
  #   ],
  #   "extAttrs": [],
  #   "partial": false
  # }

  class HTMLDetailsElement < HTMLElement
    include Prism::BindingHelpers

    # def initialize()
    # end

    bind_attr_accessor :open, return_type: 'boolean'
  end

  class HTMLDialogElement < HTMLElement
    include Prism::BindingHelpers

    # def initialize()
    # end

    bind_attr_accessor :open, return_type: 'boolean'
    bind_attr_accessor :returnValue, return_type: 'DOMString'

    bind_operation :show, return_type: 'undefined', args: []
    bind_operation :showModal, return_type: 'undefined', args: []
    bind_operation :close, return_type: 'undefined', args: [
      {"name":"returnValue","type":"DOMString","optional":true}
    ]
  end

  class HTMLScriptElement < HTMLElement
    include Prism::BindingHelpers

    # def initialize()
    # end

    bind_attr_accessor :src, return_type: 'USVString'
    bind_attr_accessor :type, return_type: 'DOMString'
    bind_attr_accessor :noModule, return_type: 'boolean'
    bind_attr_accessor :async, return_type: 'boolean'
    bind_attr_accessor :defer, return_type: 'boolean'
    bind_attr_accessor :crossOrigin, return_type: 'DOMString'
    bind_attr_accessor :text, return_type: 'DOMString'
    bind_attr_accessor :integrity, return_type: 'DOMString'
    bind_attr_accessor :referrerPolicy, return_type: 'DOMString'

    bind_operation :supports, return_type: 'boolean', args: [
      {"name":"type","type":"DOMString","optional":false}
    ]
  end

  class HTMLTemplateElement < HTMLElement
    include Prism::BindingHelpers

    # def initialize()
    # end

    bind_attr_reader :content, return_type: 'DocumentFragment'
  end

  class HTMLSlotElement < HTMLElement
    include Prism::BindingHelpers

    # def initialize()
    # end

    bind_attr_accessor :name, return_type: 'DOMString'

    bind_operation :assignedNodes, return_type: 'Node', args: [
      {"name":"options","type":"AssignedNodesOptions","optional":true}
    ]
    bind_operation :assignedElements, return_type: 'Element', args: [
      {"name":"options","type":"AssignedNodesOptions","optional":true}
    ]
    bind_operation :assign, return_type: 'undefined', args: [
      {"name":"nodes","type":"Element | Text","optional":false}
    ]
  end

  # Skipped definition, name=AssignedNodesOptions, type='dictionary':
  # {
  #   "type": "dictionary",
  #   "name": "AssignedNodesOptions",
  #   "inheritance": null,
  #   "members": [
  #     {
  #       "type": "field",
  #       "name": "flatten",
  #       "extAttrs": [],
  #       "idlType": {
  #         "type": "dictionary-type",
  #         "extAttrs": [],
  #         "generic": "",
  #         "nullable": false,
  #         "union": false,
  #         "idlType": "boolean"
  #       },
  #       "default": {
  #         "type": "boolean",
  #         "value": false
  #       },
  #       "required": false
  #     }
  #   ],
  #   "extAttrs": [],
  #   "partial": false
  # }

  RenderingContext = TypeDef.new("RenderingContext", types: ["CanvasRenderingContext2D","ImageBitmapRenderingContext","WebGLRenderingContext","WebGL2RenderingContext","GPUCanvasContext"])

  class HTMLCanvasElement < HTMLElement
    include Prism::BindingHelpers

    # def initialize()
    # end

    bind_attr_accessor :width, return_type: 'unsigned long'
    bind_attr_accessor :height, return_type: 'unsigned long'

    bind_operation :getContext, return_type: 'RenderingContext', args: [
      {"name":"contextId","type":"DOMString","optional":false},
      {"name":"options","type":"any","optional":true}
    ]
    bind_operation :toDataURL, return_type: 'USVString', args: [
      {"name":"type","type":"DOMString","optional":true},
      {"name":"quality","type":"any","optional":true}
    ]
    bind_operation :toBlob, return_type: 'undefined', args: [
      {"name":"callback","type":"BlobCallback","optional":false},
      {"name":"type","type":"DOMString","optional":true},
      {"name":"quality","type":"any","optional":true}
    ]
    bind_operation :transferControlToOffscreen, return_type: 'OffscreenCanvas', args: []
  end

  BlobCallback = CallbackInterface.new("BlobCallback", args: [
    {"name":"blob","type":"Blob","optional":false}
  ])

  HTMLOrSVGImageElement = TypeDef.new("HTMLOrSVGImageElement", types: ["HTMLImageElement","SVGImageElement"])

  CanvasImageSource = TypeDef.new("CanvasImageSource", types: ["HTMLOrSVGImageElement","HTMLVideoElement","HTMLCanvasElement","ImageBitmap","OffscreenCanvas","VideoFrame"])

  # Skipped definition, name=PredefinedColorSpace, type='enum':
  # {
  #   "type": "enum",
  #   "name": "PredefinedColorSpace",
  #   "values": [
  #     {
  #       "type": "enum-value",
  #       "value": "srgb"
  #     },
  #     {
  #       "type": "enum-value",
  #       "value": "display-p3"
  #     }
  #   ],
  #   "extAttrs": []
  # }

  # Skipped definition, name=CanvasFillRule, type='enum':
  # {
  #   "type": "enum",
  #   "name": "CanvasFillRule",
  #   "values": [
  #     {
  #       "type": "enum-value",
  #       "value": "nonzero"
  #     },
  #     {
  #       "type": "enum-value",
  #       "value": "evenodd"
  #     }
  #   ],
  #   "extAttrs": []
  # }

  # Skipped definition, name=CanvasRenderingContext2DSettings, type='dictionary':
  # {
  #   "type": "dictionary",
  #   "name": "CanvasRenderingContext2DSettings",
  #   "inheritance": null,
  #   "members": [
  #     {
  #       "type": "field",
  #       "name": "alpha",
  #       "extAttrs": [],
  #       "idlType": {
  #         "type": "dictionary-type",
  #         "extAttrs": [],
  #         "generic": "",
  #         "nullable": false,
  #         "union": false,
  #         "idlType": "boolean"
  #       },
  #       "default": {
  #         "type": "boolean",
  #         "value": true
  #       },
  #       "required": false
  #     },
  #     {
  #       "type": "field",
  #       "name": "desynchronized",
  #       "extAttrs": [],
  #       "idlType": {
  #         "type": "dictionary-type",
  #         "extAttrs": [],
  #         "generic": "",
  #         "nullable": false,
  #         "union": false,
  #         "idlType": "boolean"
  #       },
  #       "default": {
  #         "type": "boolean",
  #         "value": false
  #       },
  #       "required": false
  #     },
  #     {
  #       "type": "field",
  #       "name": "colorSpace",
  #       "extAttrs": [],
  #       "idlType": {
  #         "type": "dictionary-type",
  #         "extAttrs": [],
  #         "generic": "",
  #         "nullable": false,
  #         "union": false,
  #         "idlType": "PredefinedColorSpace"
  #       },
  #       "default": {
  #         "type": "string",
  #         "value": "srgb"
  #       },
  #       "required": false
  #     },
  #     {
  #       "type": "field",
  #       "name": "willReadFrequently",
  #       "extAttrs": [],
  #       "idlType": {
  #         "type": "dictionary-type",
  #         "extAttrs": [],
  #         "generic": "",
  #         "nullable": false,
  #         "union": false,
  #         "idlType": "boolean"
  #       },
  #       "default": {
  #         "type": "boolean",
  #         "value": false
  #       },
  #       "required": false
  #     }
  #   ],
  #   "extAttrs": [],
  #   "partial": false
  # }

  # Skipped definition, name=ImageSmoothingQuality, type='enum':
  # {
  #   "type": "enum",
  #   "name": "ImageSmoothingQuality",
  #   "values": [
  #     {
  #       "type": "enum-value",
  #       "value": "low"
  #     },
  #     {
  #       "type": "enum-value",
  #       "value": "medium"
  #     },
  #     {
  #       "type": "enum-value",
  #       "value": "high"
  #     }
  #   ],
  #   "extAttrs": []
  # }

  class CanvasRenderingContext2D < Prism::Binding
    include Prism::BindingHelpers

    bind_attr_reader :canvas, return_type: 'HTMLCanvasElement'

    bind_operation :getContextAttributes, return_type: 'CanvasRenderingContext2DSettings', args: []
  end

  module CanvasState
    include Prism::BindingHelpers

    bind_operation :save, return_type: 'undefined', args: []
    bind_operation :restore, return_type: 'undefined', args: []
    bind_operation :reset, return_type: 'undefined', args: []
    bind_operation :isContextLost, return_type: 'boolean', args: []
  end

  module CanvasTransform
    include Prism::BindingHelpers

    bind_operation :scale, return_type: 'undefined', args: [
      {"name":"x","type":"unrestricted double","optional":false},
      {"name":"y","type":"unrestricted double","optional":false}
    ]
    bind_operation :rotate, return_type: 'undefined', args: [
      {"name":"angle","type":"unrestricted double","optional":false}
    ]
    bind_operation :translate, return_type: 'undefined', args: [
      {"name":"x","type":"unrestricted double","optional":false},
      {"name":"y","type":"unrestricted double","optional":false}
    ]
    bind_operation :transform, return_type: 'undefined', args: [
      {"name":"a","type":"unrestricted double","optional":false},
      {"name":"b","type":"unrestricted double","optional":false},
      {"name":"c","type":"unrestricted double","optional":false},
      {"name":"d","type":"unrestricted double","optional":false},
      {"name":"e","type":"unrestricted double","optional":false},
      {"name":"f","type":"unrestricted double","optional":false}
    ]
    bind_operation :getTransform, return_type: 'DOMMatrix', args: []
    bind_operation :setTransform, return_type: 'undefined', args: [
      {"name":"a","type":"unrestricted double","optional":false},
      {"name":"b","type":"unrestricted double","optional":false},
      {"name":"c","type":"unrestricted double","optional":false},
      {"name":"d","type":"unrestricted double","optional":false},
      {"name":"e","type":"unrestricted double","optional":false},
      {"name":"f","type":"unrestricted double","optional":false}
    ]
    bind_operation :setTransform, return_type: 'undefined', args: [
      {"name":"transform","type":"DOMMatrix2DInit","optional":true}
    ]
    bind_operation :resetTransform, return_type: 'undefined', args: []
  end

  module CanvasCompositing
    include Prism::BindingHelpers

    bind_attr_accessor :globalAlpha, return_type: 'unrestricted double'
    bind_attr_accessor :globalCompositeOperation, return_type: 'DOMString'
  end

  module CanvasImageSmoothing
    include Prism::BindingHelpers

    bind_attr_accessor :imageSmoothingEnabled, return_type: 'boolean'
    bind_attr_accessor :imageSmoothingQuality, return_type: 'ImageSmoothingQuality'
  end

  module CanvasFillStrokeStyles
    include Prism::BindingHelpers

    bind_attr_accessor :strokeStyle, return_type: 'DOMString | CanvasGradient | CanvasPattern'
    bind_attr_accessor :fillStyle, return_type: 'DOMString | CanvasGradient | CanvasPattern'

    bind_operation :createLinearGradient, return_type: 'CanvasGradient', args: [
      {"name":"x0","type":"double","optional":false},
      {"name":"y0","type":"double","optional":false},
      {"name":"x1","type":"double","optional":false},
      {"name":"y1","type":"double","optional":false}
    ]
    bind_operation :createRadialGradient, return_type: 'CanvasGradient', args: [
      {"name":"x0","type":"double","optional":false},
      {"name":"y0","type":"double","optional":false},
      {"name":"r0","type":"double","optional":false},
      {"name":"x1","type":"double","optional":false},
      {"name":"y1","type":"double","optional":false},
      {"name":"r1","type":"double","optional":false}
    ]
    bind_operation :createConicGradient, return_type: 'CanvasGradient', args: [
      {"name":"startAngle","type":"double","optional":false},
      {"name":"x","type":"double","optional":false},
      {"name":"y","type":"double","optional":false}
    ]
    bind_operation :createPattern, return_type: 'CanvasPattern', args: [
      {"name":"image","type":"CanvasImageSource","optional":false},
      {"name":"repetition","type":"DOMString","optional":false}
    ]
  end

  module CanvasShadowStyles
    include Prism::BindingHelpers

    bind_attr_accessor :shadowOffsetX, return_type: 'unrestricted double'
    bind_attr_accessor :shadowOffsetY, return_type: 'unrestricted double'
    bind_attr_accessor :shadowBlur, return_type: 'unrestricted double'
    bind_attr_accessor :shadowColor, return_type: 'DOMString'
  end

  module CanvasFilters
    include Prism::BindingHelpers

    bind_attr_accessor :filter, return_type: 'DOMString'
  end

  module CanvasRect
    include Prism::BindingHelpers

    bind_operation :clearRect, return_type: 'undefined', args: [
      {"name":"x","type":"unrestricted double","optional":false},
      {"name":"y","type":"unrestricted double","optional":false},
      {"name":"w","type":"unrestricted double","optional":false},
      {"name":"h","type":"unrestricted double","optional":false}
    ]
    bind_operation :fillRect, return_type: 'undefined', args: [
      {"name":"x","type":"unrestricted double","optional":false},
      {"name":"y","type":"unrestricted double","optional":false},
      {"name":"w","type":"unrestricted double","optional":false},
      {"name":"h","type":"unrestricted double","optional":false}
    ]
    bind_operation :strokeRect, return_type: 'undefined', args: [
      {"name":"x","type":"unrestricted double","optional":false},
      {"name":"y","type":"unrestricted double","optional":false},
      {"name":"w","type":"unrestricted double","optional":false},
      {"name":"h","type":"unrestricted double","optional":false}
    ]
  end

  module CanvasDrawPath
    include Prism::BindingHelpers

    bind_operation :beginPath, return_type: 'undefined', args: []
    bind_operation :fill, return_type: 'undefined', args: [
      {"name":"fillRule","type":"CanvasFillRule","optional":true}
    ]
    bind_operation :fill, return_type: 'undefined', args: [
      {"name":"path","type":"Path2D","optional":false},
      {"name":"fillRule","type":"CanvasFillRule","optional":true}
    ]
    bind_operation :stroke, return_type: 'undefined', args: []
    bind_operation :stroke, return_type: 'undefined', args: [
      {"name":"path","type":"Path2D","optional":false}
    ]
    bind_operation :clip, return_type: 'undefined', args: [
      {"name":"fillRule","type":"CanvasFillRule","optional":true}
    ]
    bind_operation :clip, return_type: 'undefined', args: [
      {"name":"path","type":"Path2D","optional":false},
      {"name":"fillRule","type":"CanvasFillRule","optional":true}
    ]
    bind_operation :isPointInPath, return_type: 'boolean', args: [
      {"name":"x","type":"unrestricted double","optional":false},
      {"name":"y","type":"unrestricted double","optional":false},
      {"name":"fillRule","type":"CanvasFillRule","optional":true}
    ]
    bind_operation :isPointInPath, return_type: 'boolean', args: [
      {"name":"path","type":"Path2D","optional":false},
      {"name":"x","type":"unrestricted double","optional":false},
      {"name":"y","type":"unrestricted double","optional":false},
      {"name":"fillRule","type":"CanvasFillRule","optional":true}
    ]
    bind_operation :isPointInStroke, return_type: 'boolean', args: [
      {"name":"x","type":"unrestricted double","optional":false},
      {"name":"y","type":"unrestricted double","optional":false}
    ]
    bind_operation :isPointInStroke, return_type: 'boolean', args: [
      {"name":"path","type":"Path2D","optional":false},
      {"name":"x","type":"unrestricted double","optional":false},
      {"name":"y","type":"unrestricted double","optional":false}
    ]
  end

  module CanvasUserInterface
    include Prism::BindingHelpers

    bind_operation :drawFocusIfNeeded, return_type: 'undefined', args: [
      {"name":"element","type":"Element","optional":false}
    ]
    bind_operation :drawFocusIfNeeded, return_type: 'undefined', args: [
      {"name":"path","type":"Path2D","optional":false},
      {"name":"element","type":"Element","optional":false}
    ]
    bind_operation :scrollPathIntoView, return_type: 'undefined', args: []
    bind_operation :scrollPathIntoView, return_type: 'undefined', args: [
      {"name":"path","type":"Path2D","optional":false}
    ]
  end

  module CanvasText
    include Prism::BindingHelpers

    bind_operation :fillText, return_type: 'undefined', args: [
      {"name":"text","type":"DOMString","optional":false},
      {"name":"x","type":"unrestricted double","optional":false},
      {"name":"y","type":"unrestricted double","optional":false},
      {"name":"maxWidth","type":"unrestricted double","optional":true}
    ]
    bind_operation :strokeText, return_type: 'undefined', args: [
      {"name":"text","type":"DOMString","optional":false},
      {"name":"x","type":"unrestricted double","optional":false},
      {"name":"y","type":"unrestricted double","optional":false},
      {"name":"maxWidth","type":"unrestricted double","optional":true}
    ]
    bind_operation :measureText, return_type: 'TextMetrics', args: [
      {"name":"text","type":"DOMString","optional":false}
    ]
  end

  module CanvasDrawImage
    include Prism::BindingHelpers

    bind_operation :drawImage, return_type: 'undefined', args: [
      {"name":"image","type":"CanvasImageSource","optional":false},
      {"name":"dx","type":"unrestricted double","optional":false},
      {"name":"dy","type":"unrestricted double","optional":false}
    ]
    bind_operation :drawImage, return_type: 'undefined', args: [
      {"name":"image","type":"CanvasImageSource","optional":false},
      {"name":"dx","type":"unrestricted double","optional":false},
      {"name":"dy","type":"unrestricted double","optional":false},
      {"name":"dw","type":"unrestricted double","optional":false},
      {"name":"dh","type":"unrestricted double","optional":false}
    ]
    bind_operation :drawImage, return_type: 'undefined', args: [
      {"name":"image","type":"CanvasImageSource","optional":false},
      {"name":"sx","type":"unrestricted double","optional":false},
      {"name":"sy","type":"unrestricted double","optional":false},
      {"name":"sw","type":"unrestricted double","optional":false},
      {"name":"sh","type":"unrestricted double","optional":false},
      {"name":"dx","type":"unrestricted double","optional":false},
      {"name":"dy","type":"unrestricted double","optional":false},
      {"name":"dw","type":"unrestricted double","optional":false},
      {"name":"dh","type":"unrestricted double","optional":false}
    ]
  end

  module CanvasImageData
    include Prism::BindingHelpers

    bind_operation :createImageData, return_type: 'ImageData', args: [
      {"name":"sw","type":"long","optional":false},
      {"name":"sh","type":"long","optional":false},
      {"name":"settings","type":"ImageDataSettings","optional":true}
    ]
    bind_operation :createImageData, return_type: 'ImageData', args: [
      {"name":"imagedata","type":"ImageData","optional":false}
    ]
    bind_operation :getImageData, return_type: 'ImageData', args: [
      {"name":"sx","type":"long","optional":false},
      {"name":"sy","type":"long","optional":false},
      {"name":"sw","type":"long","optional":false},
      {"name":"sh","type":"long","optional":false},
      {"name":"settings","type":"ImageDataSettings","optional":true}
    ]
    bind_operation :putImageData, return_type: 'undefined', args: [
      {"name":"imagedata","type":"ImageData","optional":false},
      {"name":"dx","type":"long","optional":false},
      {"name":"dy","type":"long","optional":false}
    ]
    bind_operation :putImageData, return_type: 'undefined', args: [
      {"name":"imagedata","type":"ImageData","optional":false},
      {"name":"dx","type":"long","optional":false},
      {"name":"dy","type":"long","optional":false},
      {"name":"dirtyX","type":"long","optional":false},
      {"name":"dirtyY","type":"long","optional":false},
      {"name":"dirtyWidth","type":"long","optional":false},
      {"name":"dirtyHeight","type":"long","optional":false}
    ]
  end

  # Skipped definition, name=CanvasLineCap, type='enum':
  # {
  #   "type": "enum",
  #   "name": "CanvasLineCap",
  #   "values": [
  #     {
  #       "type": "enum-value",
  #       "value": "butt"
  #     },
  #     {
  #       "type": "enum-value",
  #       "value": "round"
  #     },
  #     {
  #       "type": "enum-value",
  #       "value": "square"
  #     }
  #   ],
  #   "extAttrs": []
  # }

  # Skipped definition, name=CanvasLineJoin, type='enum':
  # {
  #   "type": "enum",
  #   "name": "CanvasLineJoin",
  #   "values": [
  #     {
  #       "type": "enum-value",
  #       "value": "round"
  #     },
  #     {
  #       "type": "enum-value",
  #       "value": "bevel"
  #     },
  #     {
  #       "type": "enum-value",
  #       "value": "miter"
  #     }
  #   ],
  #   "extAttrs": []
  # }

  # Skipped definition, name=CanvasTextAlign, type='enum':
  # {
  #   "type": "enum",
  #   "name": "CanvasTextAlign",
  #   "values": [
  #     {
  #       "type": "enum-value",
  #       "value": "start"
  #     },
  #     {
  #       "type": "enum-value",
  #       "value": "end"
  #     },
  #     {
  #       "type": "enum-value",
  #       "value": "left"
  #     },
  #     {
  #       "type": "enum-value",
  #       "value": "right"
  #     },
  #     {
  #       "type": "enum-value",
  #       "value": "center"
  #     }
  #   ],
  #   "extAttrs": []
  # }

  # Skipped definition, name=CanvasTextBaseline, type='enum':
  # {
  #   "type": "enum",
  #   "name": "CanvasTextBaseline",
  #   "values": [
  #     {
  #       "type": "enum-value",
  #       "value": "top"
  #     },
  #     {
  #       "type": "enum-value",
  #       "value": "hanging"
  #     },
  #     {
  #       "type": "enum-value",
  #       "value": "middle"
  #     },
  #     {
  #       "type": "enum-value",
  #       "value": "alphabetic"
  #     },
  #     {
  #       "type": "enum-value",
  #       "value": "ideographic"
  #     },
  #     {
  #       "type": "enum-value",
  #       "value": "bottom"
  #     }
  #   ],
  #   "extAttrs": []
  # }

  # Skipped definition, name=CanvasDirection, type='enum':
  # {
  #   "type": "enum",
  #   "name": "CanvasDirection",
  #   "values": [
  #     {
  #       "type": "enum-value",
  #       "value": "ltr"
  #     },
  #     {
  #       "type": "enum-value",
  #       "value": "rtl"
  #     },
  #     {
  #       "type": "enum-value",
  #       "value": "inherit"
  #     }
  #   ],
  #   "extAttrs": []
  # }

  # Skipped definition, name=CanvasFontKerning, type='enum':
  # {
  #   "type": "enum",
  #   "name": "CanvasFontKerning",
  #   "values": [
  #     {
  #       "type": "enum-value",
  #       "value": "auto"
  #     },
  #     {
  #       "type": "enum-value",
  #       "value": "normal"
  #     },
  #     {
  #       "type": "enum-value",
  #       "value": "none"
  #     }
  #   ],
  #   "extAttrs": []
  # }

  # Skipped definition, name=CanvasFontStretch, type='enum':
  # {
  #   "type": "enum",
  #   "name": "CanvasFontStretch",
  #   "values": [
  #     {
  #       "type": "enum-value",
  #       "value": "ultra-condensed"
  #     },
  #     {
  #       "type": "enum-value",
  #       "value": "extra-condensed"
  #     },
  #     {
  #       "type": "enum-value",
  #       "value": "condensed"
  #     },
  #     {
  #       "type": "enum-value",
  #       "value": "semi-condensed"
  #     },
  #     {
  #       "type": "enum-value",
  #       "value": "normal"
  #     },
  #     {
  #       "type": "enum-value",
  #       "value": "semi-expanded"
  #     },
  #     {
  #       "type": "enum-value",
  #       "value": "expanded"
  #     },
  #     {
  #       "type": "enum-value",
  #       "value": "extra-expanded"
  #     },
  #     {
  #       "type": "enum-value",
  #       "value": "ultra-expanded"
  #     }
  #   ],
  #   "extAttrs": []
  # }

  # Skipped definition, name=CanvasFontVariantCaps, type='enum':
  # {
  #   "type": "enum",
  #   "name": "CanvasFontVariantCaps",
  #   "values": [
  #     {
  #       "type": "enum-value",
  #       "value": "normal"
  #     },
  #     {
  #       "type": "enum-value",
  #       "value": "small-caps"
  #     },
  #     {
  #       "type": "enum-value",
  #       "value": "all-small-caps"
  #     },
  #     {
  #       "type": "enum-value",
  #       "value": "petite-caps"
  #     },
  #     {
  #       "type": "enum-value",
  #       "value": "all-petite-caps"
  #     },
  #     {
  #       "type": "enum-value",
  #       "value": "unicase"
  #     },
  #     {
  #       "type": "enum-value",
  #       "value": "titling-caps"
  #     }
  #   ],
  #   "extAttrs": []
  # }

  # Skipped definition, name=CanvasTextRendering, type='enum':
  # {
  #   "type": "enum",
  #   "name": "CanvasTextRendering",
  #   "values": [
  #     {
  #       "type": "enum-value",
  #       "value": "auto"
  #     },
  #     {
  #       "type": "enum-value",
  #       "value": "optimizeSpeed"
  #     },
  #     {
  #       "type": "enum-value",
  #       "value": "optimizeLegibility"
  #     },
  #     {
  #       "type": "enum-value",
  #       "value": "geometricPrecision"
  #     }
  #   ],
  #   "extAttrs": []
  # }

  module CanvasPathDrawingStyles
    include Prism::BindingHelpers

    bind_attr_accessor :lineWidth, return_type: 'unrestricted double'
    bind_attr_accessor :lineCap, return_type: 'CanvasLineCap'
    bind_attr_accessor :lineJoin, return_type: 'CanvasLineJoin'
    bind_attr_accessor :miterLimit, return_type: 'unrestricted double'
    bind_attr_accessor :lineDashOffset, return_type: 'unrestricted double'

    bind_operation :setLineDash, return_type: 'undefined', args: [
      {"name":"segments","type":"unrestricted double","optional":false}
    ]
    bind_operation :getLineDash, return_type: 'unrestricted double', args: []
  end

  module CanvasTextDrawingStyles
    include Prism::BindingHelpers

    bind_attr_accessor :font, return_type: 'DOMString'
    bind_attr_accessor :textAlign, return_type: 'CanvasTextAlign'
    bind_attr_accessor :textBaseline, return_type: 'CanvasTextBaseline'
    bind_attr_accessor :direction, return_type: 'CanvasDirection'
    bind_attr_accessor :textLetterSpacing, return_type: 'double'
    bind_attr_accessor :textWordSpacing, return_type: 'double'
    bind_attr_accessor :fontKerning, return_type: 'CanvasFontKerning'
    bind_attr_accessor :fontStretch, return_type: 'CanvasFontStretch'
    bind_attr_accessor :fontVariantCaps, return_type: 'CanvasFontVariantCaps'
    bind_attr_accessor :textRendering, return_type: 'CanvasTextRendering'
  end

  module CanvasPath
    include Prism::BindingHelpers

    bind_operation :closePath, return_type: 'undefined', args: []
    bind_operation :moveTo, return_type: 'undefined', args: [
      {"name":"x","type":"unrestricted double","optional":false},
      {"name":"y","type":"unrestricted double","optional":false}
    ]
    bind_operation :lineTo, return_type: 'undefined', args: [
      {"name":"x","type":"unrestricted double","optional":false},
      {"name":"y","type":"unrestricted double","optional":false}
    ]
    bind_operation :quadraticCurveTo, return_type: 'undefined', args: [
      {"name":"cpx","type":"unrestricted double","optional":false},
      {"name":"cpy","type":"unrestricted double","optional":false},
      {"name":"x","type":"unrestricted double","optional":false},
      {"name":"y","type":"unrestricted double","optional":false}
    ]
    bind_operation :bezierCurveTo, return_type: 'undefined', args: [
      {"name":"cp1x","type":"unrestricted double","optional":false},
      {"name":"cp1y","type":"unrestricted double","optional":false},
      {"name":"cp2x","type":"unrestricted double","optional":false},
      {"name":"cp2y","type":"unrestricted double","optional":false},
      {"name":"x","type":"unrestricted double","optional":false},
      {"name":"y","type":"unrestricted double","optional":false}
    ]
    bind_operation :arcTo, return_type: 'undefined', args: [
      {"name":"x1","type":"unrestricted double","optional":false},
      {"name":"y1","type":"unrestricted double","optional":false},
      {"name":"x2","type":"unrestricted double","optional":false},
      {"name":"y2","type":"unrestricted double","optional":false},
      {"name":"radius","type":"unrestricted double","optional":false}
    ]
    bind_operation :rect, return_type: 'undefined', args: [
      {"name":"x","type":"unrestricted double","optional":false},
      {"name":"y","type":"unrestricted double","optional":false},
      {"name":"w","type":"unrestricted double","optional":false},
      {"name":"h","type":"unrestricted double","optional":false}
    ]
    bind_operation :roundRect, return_type: 'undefined', args: [
      {"name":"x","type":"unrestricted double","optional":false},
      {"name":"y","type":"unrestricted double","optional":false},
      {"name":"w","type":"unrestricted double","optional":false},
      {"name":"h","type":"unrestricted double","optional":false},
      {"name":"radii","type":"[object Object],[object Object]","optional":false}
    ]
    bind_operation :arc, return_type: 'undefined', args: [
      {"name":"x","type":"unrestricted double","optional":false},
      {"name":"y","type":"unrestricted double","optional":false},
      {"name":"radius","type":"unrestricted double","optional":false},
      {"name":"startAngle","type":"unrestricted double","optional":false},
      {"name":"endAngle","type":"unrestricted double","optional":false},
      {"name":"counterclockwise","type":"boolean","optional":true}
    ]
    bind_operation :ellipse, return_type: 'undefined', args: [
      {"name":"x","type":"unrestricted double","optional":false},
      {"name":"y","type":"unrestricted double","optional":false},
      {"name":"radiusX","type":"unrestricted double","optional":false},
      {"name":"radiusY","type":"unrestricted double","optional":false},
      {"name":"rotation","type":"unrestricted double","optional":false},
      {"name":"startAngle","type":"unrestricted double","optional":false},
      {"name":"endAngle","type":"unrestricted double","optional":false},
      {"name":"counterclockwise","type":"boolean","optional":true}
    ]
  end

  class CanvasGradient < Prism::Binding
    include Prism::BindingHelpers

    bind_operation :addColorStop, return_type: 'undefined', args: [
      {"name":"offset","type":"double","optional":false},
      {"name":"color","type":"DOMString","optional":false}
    ]
  end

  class CanvasPattern < Prism::Binding
    include Prism::BindingHelpers

    bind_operation :setTransform, return_type: 'undefined', args: [
      {"name":"transform","type":"DOMMatrix2DInit","optional":true}
    ]
  end

  class TextMetrics < Prism::Binding
    include Prism::BindingHelpers

    bind_attr_reader :width, return_type: 'double'
    bind_attr_reader :actualBoundingBoxLeft, return_type: 'double'
    bind_attr_reader :actualBoundingBoxRight, return_type: 'double'
    bind_attr_reader :fontBoundingBoxAscent, return_type: 'double'
    bind_attr_reader :fontBoundingBoxDescent, return_type: 'double'
    bind_attr_reader :actualBoundingBoxAscent, return_type: 'double'
    bind_attr_reader :actualBoundingBoxDescent, return_type: 'double'
    bind_attr_reader :emHeightAscent, return_type: 'double'
    bind_attr_reader :emHeightDescent, return_type: 'double'
    bind_attr_reader :hangingBaseline, return_type: 'double'
    bind_attr_reader :alphabeticBaseline, return_type: 'double'
    bind_attr_reader :ideographicBaseline, return_type: 'double'
  end

  # Skipped definition, name=ImageDataSettings, type='dictionary':
  # {
  #   "type": "dictionary",
  #   "name": "ImageDataSettings",
  #   "inheritance": null,
  #   "members": [
  #     {
  #       "type": "field",
  #       "name": "colorSpace",
  #       "extAttrs": [],
  #       "idlType": {
  #         "type": "dictionary-type",
  #         "extAttrs": [],
  #         "generic": "",
  #         "nullable": false,
  #         "union": false,
  #         "idlType": "PredefinedColorSpace"
  #       },
  #       "default": null,
  #       "required": false
  #     }
  #   ],
  #   "extAttrs": [],
  #   "partial": false
  # }

  class ImageData < Prism::Binding
    include Prism::BindingHelpers

    # def initialize(sw, sh, settings = UNDEFINED)
    # end
    # def initialize(data, sw, sh = UNDEFINED, settings = UNDEFINED)
    # end

    bind_attr_reader :width, return_type: 'unsigned long'
    bind_attr_reader :height, return_type: 'unsigned long'
    bind_attr_reader :data, return_type: 'Uint8ClampedArray'
    bind_attr_reader :colorSpace, return_type: 'PredefinedColorSpace'
  end

  class Path2D < Prism::Binding
    include Prism::BindingHelpers

    # def initialize(path = UNDEFINED)
    # end

    bind_operation :addPath, return_type: 'undefined', args: [
      {"name":"path","type":"Path2D","optional":false},
      {"name":"transform","type":"DOMMatrix2DInit","optional":true}
    ]
  end

  class ImageBitmapRenderingContext < Prism::Binding
    include Prism::BindingHelpers

    bind_attr_reader :canvas, return_type: 'HTMLCanvasElement | OffscreenCanvas'

    bind_operation :transferFromImageBitmap, return_type: 'undefined', args: [
      {"name":"bitmap","type":"ImageBitmap","optional":false}
    ]
  end

  # Skipped definition, name=ImageBitmapRenderingContextSettings, type='dictionary':
  # {
  #   "type": "dictionary",
  #   "name": "ImageBitmapRenderingContextSettings",
  #   "inheritance": null,
  #   "members": [
  #     {
  #       "type": "field",
  #       "name": "alpha",
  #       "extAttrs": [],
  #       "idlType": {
  #         "type": "dictionary-type",
  #         "extAttrs": [],
  #         "generic": "",
  #         "nullable": false,
  #         "union": false,
  #         "idlType": "boolean"
  #       },
  #       "default": {
  #         "type": "boolean",
  #         "value": true
  #       },
  #       "required": false
  #     }
  #   ],
  #   "extAttrs": [],
  #   "partial": false
  # }

  OffscreenRenderingContext = TypeDef.new("OffscreenRenderingContext", types: ["OffscreenCanvasRenderingContext2D","ImageBitmapRenderingContext","WebGLRenderingContext","WebGL2RenderingContext","GPUCanvasContext"])
end