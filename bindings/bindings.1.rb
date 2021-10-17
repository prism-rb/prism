module JS
  # Skipped definition, name=ImageEncodeOptions, type='dictionary':
  # {
  #   "type": "dictionary",
  #   "name": "ImageEncodeOptions",
  #   "inheritance": null,
  #   "members": [
  #     {
  #       "type": "field",
  #       "name": "type",
  #       "extAttrs": [],
  #       "idlType": {
  #         "type": "dictionary-type",
  #         "extAttrs": [],
  #         "generic": "",
  #         "nullable": false,
  #         "union": false,
  #         "idlType": "DOMString"
  #       },
  #       "default": {
  #         "type": "string",
  #         "value": "image/png"
  #       },
  #       "required": false
  #     },
  #     {
  #       "type": "field",
  #       "name": "quality",
  #       "extAttrs": [],
  #       "idlType": {
  #         "type": "dictionary-type",
  #         "extAttrs": [],
  #         "generic": "",
  #         "nullable": false,
  #         "union": false,
  #         "idlType": "unrestricted double"
  #       },
  #       "default": null,
  #       "required": false
  #     }
  #   ],
  #   "extAttrs": [],
  #   "partial": false
  # }

  # Skipped definition, name=OffscreenRenderingContextId, type='enum':
  # {
  #   "type": "enum",
  #   "name": "OffscreenRenderingContextId",
  #   "values": [
  #     {
  #       "type": "enum-value",
  #       "value": "2d"
  #     },
  #     {
  #       "type": "enum-value",
  #       "value": "bitmaprenderer"
  #     },
  #     {
  #       "type": "enum-value",
  #       "value": "webgl"
  #     },
  #     {
  #       "type": "enum-value",
  #       "value": "webgl2"
  #     },
  #     {
  #       "type": "enum-value",
  #       "value": "webgpu"
  #     }
  #   ],
  #   "extAttrs": []
  # }

  class OffscreenCanvas < EventTarget
    include Prism::BindingHelpers

    # def initialize(width, height)
    # end

    bind_attr_accessor :width, return_type: 'unsigned long long'
    bind_attr_accessor :height, return_type: 'unsigned long long'
    bind_attr_accessor :oncontextlost, return_type: 'EventHandler'
    bind_attr_accessor :oncontextrestored, return_type: 'EventHandler'

    bind_operation :getContext, return_type: 'OffscreenRenderingContext', args: [
      {"name":"contextId","type":"OffscreenRenderingContextId","optional":false},
      {"name":"options","type":"any","optional":true}
    ]
    bind_operation :transferToImageBitmap, return_type: 'ImageBitmap', args: []
    bind_operation :convertToBlob, return_type: 'Blob', args: [
      {"name":"options","type":"ImageEncodeOptions","optional":true}
    ]
  end

  class OffscreenCanvasRenderingContext2D < Prism::Binding
    include Prism::BindingHelpers

    bind_attr_reader :canvas, return_type: 'OffscreenCanvas'

    bind_operation :commit, return_type: 'undefined', args: []
  end

  class CustomElementRegistry < Prism::Binding
    include Prism::BindingHelpers

    bind_operation :define, return_type: 'undefined', args: [
      {"name":"name","type":"DOMString","optional":false},
      {"name":"constructor","type":"CustomElementConstructor","optional":false},
      {"name":"options","type":"ElementDefinitionOptions","optional":true}
    ]
    bind_operation :get, return_type: 'CustomElementConstructor | undefined', args: [
      {"name":"name","type":"DOMString","optional":false}
    ]
    bind_operation :whenDefined, return_type: 'CustomElementConstructor', args: [
      {"name":"name","type":"DOMString","optional":false}
    ]
    bind_operation :upgrade, return_type: 'undefined', args: [
      {"name":"root","type":"Node","optional":false}
    ]
  end

  CustomElementConstructor = CallbackInterface.new("CustomElementConstructor", args: [])

  # Skipped definition, name=ElementDefinitionOptions, type='dictionary':
  # {
  #   "type": "dictionary",
  #   "name": "ElementDefinitionOptions",
  #   "inheritance": null,
  #   "members": [
  #     {
  #       "type": "field",
  #       "name": "extends",
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

  class ElementInternals < Prism::Binding
    include Prism::BindingHelpers

    bind_attr_reader :shadowRoot, return_type: 'ShadowRoot'
    bind_attr_reader :form, return_type: 'HTMLFormElement'
    bind_attr_reader :willValidate, return_type: 'boolean'
    bind_attr_reader :validity, return_type: 'ValidityState'
    bind_attr_reader :validationMessage, return_type: 'DOMString'
    bind_attr_reader :labels, return_type: 'NodeList'

    bind_operation :setFormValue, return_type: 'undefined', args: [
      {"name":"value","type":"File | USVString | FormData","optional":false},
      {"name":"state","type":"File | USVString | FormData","optional":true}
    ]
    bind_operation :setValidity, return_type: 'undefined', args: [
      {"name":"flags","type":"ValidityStateFlags","optional":true},
      {"name":"message","type":"DOMString","optional":true},
      {"name":"anchor","type":"HTMLElement","optional":true}
    ]
    bind_operation :checkValidity, return_type: 'boolean', args: []
    bind_operation :reportValidity, return_type: 'boolean', args: []
  end

  # Skipped definition, name=ValidityStateFlags, type='dictionary':
  # {
  #   "type": "dictionary",
  #   "name": "ValidityStateFlags",
  #   "inheritance": null,
  #   "members": [
  #     {
  #       "type": "field",
  #       "name": "valueMissing",
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
  #       "name": "typeMismatch",
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
  #       "name": "patternMismatch",
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
  #       "name": "tooLong",
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
  #       "name": "tooShort",
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
  #       "name": "rangeUnderflow",
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
  #       "name": "rangeOverflow",
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
  #       "name": "stepMismatch",
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
  #       "name": "badInput",
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
  #       "name": "customError",
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

  # Skipped definition, name=FocusOptions, type='dictionary':
  # {
  #   "type": "dictionary",
  #   "name": "FocusOptions",
  #   "inheritance": null,
  #   "members": [
  #     {
  #       "type": "field",
  #       "name": "preventScroll",
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

  module ElementContentEditable
    include Prism::BindingHelpers

    bind_attr_reader :isContentEditable, return_type: 'boolean'

    bind_attr_accessor :contentEditable, return_type: 'DOMString'
    bind_attr_accessor :enterKeyHint, return_type: 'DOMString'
    bind_attr_accessor :inputMode, return_type: 'DOMString'
  end

  class DataTransfer < Prism::Binding
    include Prism::BindingHelpers

    # def initialize()
    # end

    bind_attr_reader :items, return_type: 'DataTransferItemList'
    bind_attr_reader :types, return_type: '{
      "type": "attribute",
      "name": "types",
      "idlType": {
        "type": "attribute-type",
        "extAttrs": [],
        "generic": "FrozenArray",
        "nullable": false,
        "union": false,
        "idlType": [
          {
            "type": "attribute-type",
            "extAttrs": [],
            "generic": "",
            "nullable": false,
            "union": false,
            "idlType": "DOMString"
          }
        ]
      },
      "extAttrs": [],
      "special": "",
      "readonly": true
    }'
    bind_attr_reader :files, return_type: 'FileList'

    bind_attr_accessor :dropEffect, return_type: 'DOMString'
    bind_attr_accessor :effectAllowed, return_type: 'DOMString'

    bind_operation :setDragImage, return_type: 'undefined', args: [
      {"name":"image","type":"Element","optional":false},
      {"name":"x","type":"long","optional":false},
      {"name":"y","type":"long","optional":false}
    ]
    bind_operation :getData, return_type: 'DOMString', args: [
      {"name":"format","type":"DOMString","optional":false}
    ]
    bind_operation :setData, return_type: 'undefined', args: [
      {"name":"format","type":"DOMString","optional":false},
      {"name":"data","type":"DOMString","optional":false}
    ]
    bind_operation :clearData, return_type: 'undefined', args: [
      {"name":"format","type":"DOMString","optional":true}
    ]
  end

  class DataTransferItemList < Prism::Binding
    include Prism::BindingHelpers

    bind_attr_reader :length, return_type: 'unsigned long'

    bind_operation :[], return_type: 'DataTransferItem', args: [
      {"name":"index","type":"unsigned long","optional":false}
    ]
    bind_operation :add, return_type: 'DataTransferItem', args: [
      {"name":"data","type":"DOMString","optional":false},
      {"name":"type","type":"DOMString","optional":false}
    ]
    bind_operation :add, return_type: 'DataTransferItem', args: [
      {"name":"data","type":"File","optional":false}
    ]
    bind_operation :remove, return_type: 'undefined', args: [
      {"name":"index","type":"unsigned long","optional":false}
    ]
    bind_operation :clear, return_type: 'undefined', args: []
  end

  class DataTransferItem < Prism::Binding
    include Prism::BindingHelpers

    bind_attr_reader :kind, return_type: 'DOMString'
    bind_attr_reader :type, return_type: 'DOMString'

    bind_operation :getAsString, return_type: 'undefined', args: [
      {"name":"callback","type":"FunctionStringCallback","optional":false}
    ]
    bind_operation :getAsFile, return_type: 'File', args: []
  end

  FunctionStringCallback = CallbackInterface.new("FunctionStringCallback", args: [
    {"name":"data","type":"DOMString","optional":false}
  ])

  class Window < EventTarget
    include Prism::BindingHelpers

    bind_attr_reader :window, return_type: 'WindowProxy'
    bind_attr_reader :self, return_type: 'WindowProxy'
    bind_attr_reader :document, return_type: 'Document'
    bind_attr_reader :location, return_type: 'Location'
    bind_attr_reader :history, return_type: 'History'
    bind_attr_reader :customElements, return_type: 'CustomElementRegistry'
    bind_attr_reader :locationbar, return_type: 'BarProp'
    bind_attr_reader :menubar, return_type: 'BarProp'
    bind_attr_reader :personalbar, return_type: 'BarProp'
    bind_attr_reader :scrollbars, return_type: 'BarProp'
    bind_attr_reader :statusbar, return_type: 'BarProp'
    bind_attr_reader :toolbar, return_type: 'BarProp'
    bind_attr_reader :closed, return_type: 'boolean'
    bind_attr_reader :frames, return_type: 'WindowProxy'
    bind_attr_reader :length, return_type: 'unsigned long'
    bind_attr_reader :top, return_type: 'WindowProxy'
    bind_attr_reader :parent, return_type: 'WindowProxy'
    bind_attr_reader :frameElement, return_type: 'Element'
    bind_attr_reader :navigator, return_type: 'Navigator'
    bind_attr_reader :clientInformation, return_type: 'Navigator'
    bind_attr_reader :originAgentCluster, return_type: 'boolean'

    bind_attr_accessor :name, return_type: 'DOMString'
    bind_attr_accessor :status, return_type: 'DOMString'
    bind_attr_accessor :opener, return_type: 'any'

    bind_operation :close, return_type: 'undefined', args: []
    bind_operation :stop, return_type: 'undefined', args: []
    bind_operation :focus, return_type: 'undefined', args: []
    bind_operation :blur, return_type: 'undefined', args: []
    bind_operation :open, return_type: 'WindowProxy', args: [
      {"name":"url","type":"USVString","optional":true},
      {"name":"target","type":"DOMString","optional":true},
      {"name":"features","type":"DOMString","optional":true}
    ]
    bind_operation :[], return_type: 'object', args: [
      {"name":"name","type":"DOMString","optional":false}
    ]
    bind_operation :alert, return_type: 'undefined', args: []
    bind_operation :alert, return_type: 'undefined', args: [
      {"name":"message","type":"DOMString","optional":false}
    ]
    bind_operation :confirm, return_type: 'boolean', args: [
      {"name":"message","type":"DOMString","optional":true}
    ]
    bind_operation :prompt, return_type: 'DOMString', args: [
      {"name":"message","type":"DOMString","optional":true},
      {"name":"default","type":"DOMString","optional":true}
    ]
    bind_operation :print, return_type: 'undefined', args: []
    bind_operation :postMessage, return_type: 'undefined', args: [
      {"name":"message","type":"any","optional":false},
      {"name":"targetOrigin","type":"USVString","optional":false},
      {"name":"transfer","type":"object","optional":true}
    ]
    bind_operation :postMessage, return_type: 'undefined', args: [
      {"name":"message","type":"any","optional":false},
      {"name":"options","type":"WindowPostMessageOptions","optional":true}
    ]
  end

  class Window
    include Prism::BindingHelpers

    bind_attr_reader :event, return_type: 'Event | undefined'
  end

  class BarProp < Prism::Binding
    include Prism::BindingHelpers

    bind_attr_reader :visible, return_type: 'boolean'
  end

  # Skipped definition, name=ScrollRestoration, type='enum':
  # {
  #   "type": "enum",
  #   "name": "ScrollRestoration",
  #   "values": [
  #     {
  #       "type": "enum-value",
  #       "value": "auto"
  #     },
  #     {
  #       "type": "enum-value",
  #       "value": "manual"
  #     }
  #   ],
  #   "extAttrs": []
  # }

  class History < Prism::Binding
    include Prism::BindingHelpers

    bind_attr_reader :length, return_type: 'unsigned long'
    bind_attr_reader :state, return_type: 'any'

    bind_attr_accessor :scrollRestoration, return_type: 'ScrollRestoration'

    bind_operation :go, return_type: 'undefined', args: [
      {"name":"delta","type":"long","optional":true}
    ]
    bind_operation :back, return_type: 'undefined', args: []
    bind_operation :forward, return_type: 'undefined', args: []
    bind_operation :pushState, return_type: 'undefined', args: [
      {"name":"data","type":"any","optional":false},
      {"name":"unused","type":"DOMString","optional":false},
      {"name":"url","type":"USVString","optional":true}
    ]
    bind_operation :replaceState, return_type: 'undefined', args: [
      {"name":"data","type":"any","optional":false},
      {"name":"unused","type":"DOMString","optional":false},
      {"name":"url","type":"USVString","optional":true}
    ]
  end

  class Location < Prism::Binding
    include Prism::BindingHelpers

    bind_attr_reader :origin, return_type: 'USVString'
    bind_attr_reader :ancestorOrigins, return_type: 'DOMStringList'

    bind_attr_accessor :href, return_type: 'DOMString'
    bind_attr_accessor :protocol, return_type: 'USVString'
    bind_attr_accessor :host, return_type: 'USVString'
    bind_attr_accessor :hostname, return_type: 'USVString'
    bind_attr_accessor :port, return_type: 'USVString'
    bind_attr_accessor :pathname, return_type: 'USVString'
    bind_attr_accessor :search, return_type: 'USVString'
    bind_attr_accessor :hash, return_type: 'USVString'

    bind_operation :assign, return_type: 'undefined', args: [
      {"name":"url","type":"USVString","optional":false}
    ]
    bind_operation :replace, return_type: 'undefined', args: [
      {"name":"url","type":"USVString","optional":false}
    ]
    bind_operation :reload, return_type: 'undefined', args: []
  end

  class PopStateEvent < Event
    include Prism::BindingHelpers

    # def initialize(type, eventInitDict = UNDEFINED)
    # end

    bind_attr_reader :state, return_type: 'any'
  end

  # Skipped definition, name=PopStateEventInit, type='dictionary':
  # {
  #   "type": "dictionary",
  #   "name": "PopStateEventInit",
  #   "inheritance": "EventInit",
  #   "members": [
  #     {
  #       "type": "field",
  #       "name": "state",
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

  class HashChangeEvent < Event
    include Prism::BindingHelpers

    # def initialize(type, eventInitDict = UNDEFINED)
    # end

    bind_attr_reader :oldURL, return_type: 'USVString'
    bind_attr_reader :newURL, return_type: 'USVString'
  end

  # Skipped definition, name=HashChangeEventInit, type='dictionary':
  # {
  #   "type": "dictionary",
  #   "name": "HashChangeEventInit",
  #   "inheritance": "EventInit",
  #   "members": [
  #     {
  #       "type": "field",
  #       "name": "oldURL",
  #       "extAttrs": [],
  #       "idlType": {
  #         "type": "dictionary-type",
  #         "extAttrs": [],
  #         "generic": "",
  #         "nullable": false,
  #         "union": false,
  #         "idlType": "USVString"
  #       },
  #       "default": {
  #         "type": "string",
  #         "value": ""
  #       },
  #       "required": false
  #     },
  #     {
  #       "type": "field",
  #       "name": "newURL",
  #       "extAttrs": [],
  #       "idlType": {
  #         "type": "dictionary-type",
  #         "extAttrs": [],
  #         "generic": "",
  #         "nullable": false,
  #         "union": false,
  #         "idlType": "USVString"
  #       },
  #       "default": {
  #         "type": "string",
  #         "value": ""
  #       },
  #       "required": false
  #     }
  #   ],
  #   "extAttrs": [],
  #   "partial": false
  # }

  class PageTransitionEvent < Event
    include Prism::BindingHelpers

    # def initialize(type, eventInitDict = UNDEFINED)
    # end

    bind_attr_reader :persisted, return_type: 'boolean'
  end

  # Skipped definition, name=PageTransitionEventInit, type='dictionary':
  # {
  #   "type": "dictionary",
  #   "name": "PageTransitionEventInit",
  #   "inheritance": "EventInit",
  #   "members": [
  #     {
  #       "type": "field",
  #       "name": "persisted",
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

  class BeforeUnloadEvent < Event
    include Prism::BindingHelpers

    bind_attr_accessor :returnValue, return_type: 'DOMString'
  end

  class ErrorEvent < Event
    include Prism::BindingHelpers

    # def initialize(type, eventInitDict = UNDEFINED)
    # end

    bind_attr_reader :message, return_type: 'DOMString'
    bind_attr_reader :filename, return_type: 'USVString'
    bind_attr_reader :lineno, return_type: 'unsigned long'
    bind_attr_reader :colno, return_type: 'unsigned long'
    bind_attr_reader :error, return_type: 'any'
  end

  # Skipped definition, name=ErrorEventInit, type='dictionary':
  # {
  #   "type": "dictionary",
  #   "name": "ErrorEventInit",
  #   "inheritance": "EventInit",
  #   "members": [
  #     {
  #       "type": "field",
  #       "name": "message",
  #       "extAttrs": [],
  #       "idlType": {
  #         "type": "dictionary-type",
  #         "extAttrs": [],
  #         "generic": "",
  #         "nullable": false,
  #         "union": false,
  #         "idlType": "DOMString"
  #       },
  #       "default": {
  #         "type": "string",
  #         "value": ""
  #       },
  #       "required": false
  #     },
  #     {
  #       "type": "field",
  #       "name": "filename",
  #       "extAttrs": [],
  #       "idlType": {
  #         "type": "dictionary-type",
  #         "extAttrs": [],
  #         "generic": "",
  #         "nullable": false,
  #         "union": false,
  #         "idlType": "USVString"
  #       },
  #       "default": {
  #         "type": "string",
  #         "value": ""
  #       },
  #       "required": false
  #     },
  #     {
  #       "type": "field",
  #       "name": "lineno",
  #       "extAttrs": [],
  #       "idlType": {
  #         "type": "dictionary-type",
  #         "extAttrs": [],
  #         "generic": "",
  #         "nullable": false,
  #         "union": false,
  #         "idlType": "unsigned long"
  #       },
  #       "default": {
  #         "type": "number",
  #         "value": "0"
  #       },
  #       "required": false
  #     },
  #     {
  #       "type": "field",
  #       "name": "colno",
  #       "extAttrs": [],
  #       "idlType": {
  #         "type": "dictionary-type",
  #         "extAttrs": [],
  #         "generic": "",
  #         "nullable": false,
  #         "union": false,
  #         "idlType": "unsigned long"
  #       },
  #       "default": {
  #         "type": "number",
  #         "value": "0"
  #       },
  #       "required": false
  #     },
  #     {
  #       "type": "field",
  #       "name": "error",
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

  class PromiseRejectionEvent < Event
    include Prism::BindingHelpers

    # def initialize(type, eventInitDict)
    # end

    bind_attr_reader :promise, return_type: '{
      "type": "attribute",
      "name": "promise",
      "idlType": {
        "type": "attribute-type",
        "extAttrs": [],
        "generic": "Promise",
        "nullable": false,
        "union": false,
        "idlType": [
          {
            "type": "attribute-type",
            "extAttrs": [],
            "generic": "",
            "nullable": false,
            "union": false,
            "idlType": "any"
          }
        ]
      },
      "extAttrs": [],
      "special": "",
      "readonly": true
    }'
    bind_attr_reader :reason, return_type: 'any'
  end

  # Skipped definition, name=PromiseRejectionEventInit, type='dictionary':
  # {
  #   "type": "dictionary",
  #   "name": "PromiseRejectionEventInit",
  #   "inheritance": "EventInit",
  #   "members": [
  #     {
  #       "type": "field",
  #       "name": "promise",
  #       "extAttrs": [],
  #       "idlType": {
  #         "type": "dictionary-type",
  #         "extAttrs": [],
  #         "generic": "Promise",
  #         "nullable": false,
  #         "union": false,
  #         "idlType": [
  #           {
  #             "type": "dictionary-type",
  #             "extAttrs": [],
  #             "generic": "",
  #             "nullable": false,
  #             "union": false,
  #             "idlType": "any"
  #           }
  #         ]
  #       },
  #       "default": null,
  #       "required": true
  #     },
  #     {
  #       "type": "field",
  #       "name": "reason",
  #       "extAttrs": [],
  #       "idlType": {
  #         "type": "dictionary-type",
  #         "extAttrs": [],
  #         "generic": "",
  #         "nullable": false,
  #         "union": false,
  #         "idlType": "any"
  #       },
  #       "default": null,
  #       "required": false
  #     }
  #   ],
  #   "extAttrs": [],
  #   "partial": false
  # }

  EventHandlerNonNull = CallbackInterface.new("EventHandlerNonNull", args: [
    {"name":"event","type":"Event","optional":false}
  ])

  EventHandler = TypeDef.new("EventHandler", types: ["EventHandlerNonNull"])

  OnErrorEventHandlerNonNull = CallbackInterface.new("OnErrorEventHandlerNonNull", args: [
    {"name":"event","type":"Event | DOMString","optional":false},
    {"name":"source","type":"DOMString","optional":true},
    {"name":"lineno","type":"unsigned long","optional":true},
    {"name":"colno","type":"unsigned long","optional":true},
    {"name":"error","type":"any","optional":true}
  ])

  OnErrorEventHandler = TypeDef.new("OnErrorEventHandler", types: ["OnErrorEventHandlerNonNull"])

  OnBeforeUnloadEventHandlerNonNull = CallbackInterface.new("OnBeforeUnloadEventHandlerNonNull", args: [
    {"name":"event","type":"Event","optional":false}
  ])

  OnBeforeUnloadEventHandler = TypeDef.new("OnBeforeUnloadEventHandler", types: ["OnBeforeUnloadEventHandlerNonNull"])

  module GlobalEventHandlers
    include Prism::BindingHelpers

    bind_attr_accessor :onabort, return_type: 'EventHandler'
    bind_attr_accessor :onauxclick, return_type: 'EventHandler'
    bind_attr_accessor :onblur, return_type: 'EventHandler'
    bind_attr_accessor :oncancel, return_type: 'EventHandler'
    bind_attr_accessor :oncanplay, return_type: 'EventHandler'
    bind_attr_accessor :oncanplaythrough, return_type: 'EventHandler'
    bind_attr_accessor :onchange, return_type: 'EventHandler'
    bind_attr_accessor :onclick, return_type: 'EventHandler'
    bind_attr_accessor :onclose, return_type: 'EventHandler'
    bind_attr_accessor :oncontextlost, return_type: 'EventHandler'
    bind_attr_accessor :oncontextmenu, return_type: 'EventHandler'
    bind_attr_accessor :oncontextrestored, return_type: 'EventHandler'
    bind_attr_accessor :oncuechange, return_type: 'EventHandler'
    bind_attr_accessor :ondblclick, return_type: 'EventHandler'
    bind_attr_accessor :ondrag, return_type: 'EventHandler'
    bind_attr_accessor :ondragend, return_type: 'EventHandler'
    bind_attr_accessor :ondragenter, return_type: 'EventHandler'
    bind_attr_accessor :ondragleave, return_type: 'EventHandler'
    bind_attr_accessor :ondragover, return_type: 'EventHandler'
    bind_attr_accessor :ondragstart, return_type: 'EventHandler'
    bind_attr_accessor :ondrop, return_type: 'EventHandler'
    bind_attr_accessor :ondurationchange, return_type: 'EventHandler'
    bind_attr_accessor :onemptied, return_type: 'EventHandler'
    bind_attr_accessor :onended, return_type: 'EventHandler'
    bind_attr_accessor :onerror, return_type: 'OnErrorEventHandler'
    bind_attr_accessor :onfocus, return_type: 'EventHandler'
    bind_attr_accessor :onformdata, return_type: 'EventHandler'
    bind_attr_accessor :oninput, return_type: 'EventHandler'
    bind_attr_accessor :oninvalid, return_type: 'EventHandler'
    bind_attr_accessor :onkeydown, return_type: 'EventHandler'
    bind_attr_accessor :onkeypress, return_type: 'EventHandler'
    bind_attr_accessor :onkeyup, return_type: 'EventHandler'
    bind_attr_accessor :onload, return_type: 'EventHandler'
    bind_attr_accessor :onloadeddata, return_type: 'EventHandler'
    bind_attr_accessor :onloadedmetadata, return_type: 'EventHandler'
    bind_attr_accessor :onloadstart, return_type: 'EventHandler'
    bind_attr_accessor :onmousedown, return_type: 'EventHandler'
    bind_attr_accessor :onmouseenter, return_type: 'EventHandler'
    bind_attr_accessor :onmouseleave, return_type: 'EventHandler'
    bind_attr_accessor :onmousemove, return_type: 'EventHandler'
    bind_attr_accessor :onmouseout, return_type: 'EventHandler'
    bind_attr_accessor :onmouseover, return_type: 'EventHandler'
    bind_attr_accessor :onmouseup, return_type: 'EventHandler'
    bind_attr_accessor :onpause, return_type: 'EventHandler'
    bind_attr_accessor :onplay, return_type: 'EventHandler'
    bind_attr_accessor :onplaying, return_type: 'EventHandler'
    bind_attr_accessor :onprogress, return_type: 'EventHandler'
    bind_attr_accessor :onratechange, return_type: 'EventHandler'
    bind_attr_accessor :onreset, return_type: 'EventHandler'
    bind_attr_accessor :onresize, return_type: 'EventHandler'
    bind_attr_accessor :onscroll, return_type: 'EventHandler'
    bind_attr_accessor :onsecuritypolicyviolation, return_type: 'EventHandler'
    bind_attr_accessor :onseeked, return_type: 'EventHandler'
    bind_attr_accessor :onseeking, return_type: 'EventHandler'
    bind_attr_accessor :onselect, return_type: 'EventHandler'
    bind_attr_accessor :onslotchange, return_type: 'EventHandler'
    bind_attr_accessor :onstalled, return_type: 'EventHandler'
    bind_attr_accessor :onsubmit, return_type: 'EventHandler'
    bind_attr_accessor :onsuspend, return_type: 'EventHandler'
    bind_attr_accessor :ontimeupdate, return_type: 'EventHandler'
    bind_attr_accessor :ontoggle, return_type: 'EventHandler'
    bind_attr_accessor :onvolumechange, return_type: 'EventHandler'
    bind_attr_accessor :onwaiting, return_type: 'EventHandler'
    bind_attr_accessor :onwebkitanimationend, return_type: 'EventHandler'
    bind_attr_accessor :onwebkitanimationiteration, return_type: 'EventHandler'
    bind_attr_accessor :onwebkitanimationstart, return_type: 'EventHandler'
    bind_attr_accessor :onwebkittransitionend, return_type: 'EventHandler'
    bind_attr_accessor :onwheel, return_type: 'EventHandler'
  end

  module WindowEventHandlers
    include Prism::BindingHelpers

    bind_attr_accessor :onafterprint, return_type: 'EventHandler'
    bind_attr_accessor :onbeforeprint, return_type: 'EventHandler'
    bind_attr_accessor :onbeforeunload, return_type: 'OnBeforeUnloadEventHandler'
    bind_attr_accessor :onhashchange, return_type: 'EventHandler'
    bind_attr_accessor :onlanguagechange, return_type: 'EventHandler'
    bind_attr_accessor :onmessage, return_type: 'EventHandler'
    bind_attr_accessor :onmessageerror, return_type: 'EventHandler'
    bind_attr_accessor :onoffline, return_type: 'EventHandler'
    bind_attr_accessor :ononline, return_type: 'EventHandler'
    bind_attr_accessor :onpagehide, return_type: 'EventHandler'
    bind_attr_accessor :onpageshow, return_type: 'EventHandler'
    bind_attr_accessor :onpopstate, return_type: 'EventHandler'
    bind_attr_accessor :onrejectionhandled, return_type: 'EventHandler'
    bind_attr_accessor :onstorage, return_type: 'EventHandler'
    bind_attr_accessor :onunhandledrejection, return_type: 'EventHandler'
    bind_attr_accessor :onunload, return_type: 'EventHandler'
  end

  module DocumentAndElementEventHandlers
    include Prism::BindingHelpers

    bind_attr_accessor :oncopy, return_type: 'EventHandler'
    bind_attr_accessor :oncut, return_type: 'EventHandler'
    bind_attr_accessor :onpaste, return_type: 'EventHandler'
  end

  TimerHandler = TypeDef.new("TimerHandler", types: ["DOMString","Function"])

  module WindowOrWorkerGlobalScope
    include Prism::BindingHelpers

    bind_attr_reader :origin, return_type: 'USVString'
    bind_attr_reader :isSecureContext, return_type: 'boolean'
    bind_attr_reader :crossOriginIsolated, return_type: 'boolean'

    bind_operation :reportError, return_type: 'undefined', args: [
      {"name":"e","type":"any","optional":false}
    ]
    bind_operation :btoa, return_type: 'DOMString', args: [
      {"name":"data","type":"DOMString","optional":false}
    ]
    bind_operation :atob, return_type: 'ByteString', args: [
      {"name":"data","type":"DOMString","optional":false}
    ]
    bind_operation :setTimeout, return_type: 'long', args: [
      {"name":"handler","type":"TimerHandler","optional":false},
      {"name":"timeout","type":"long","optional":true},
      {"name":"arguments","type":"any","optional":false}
    ]
    bind_operation :clearTimeout, return_type: 'undefined', args: [
      {"name":"handle","type":"long","optional":true}
    ]
    bind_operation :setInterval, return_type: 'long', args: [
      {"name":"handler","type":"TimerHandler","optional":false},
      {"name":"timeout","type":"long","optional":true},
      {"name":"arguments","type":"any","optional":false}
    ]
    bind_operation :clearInterval, return_type: 'undefined', args: [
      {"name":"handle","type":"long","optional":true}
    ]
    bind_operation :queueMicrotask, return_type: 'undefined', args: [
      {"name":"callback","type":"VoidFunction","optional":false}
    ]
    bind_operation :createImageBitmap, return_type: 'ImageBitmap', args: [
      {"name":"image","type":"ImageBitmapSource","optional":false},
      {"name":"options","type":"ImageBitmapOptions","optional":true}
    ]
    bind_operation :createImageBitmap, return_type: 'ImageBitmap', args: [
      {"name":"image","type":"ImageBitmapSource","optional":false},
      {"name":"sx","type":"long","optional":false},
      {"name":"sy","type":"long","optional":false},
      {"name":"sw","type":"long","optional":false},
      {"name":"sh","type":"long","optional":false},
      {"name":"options","type":"ImageBitmapOptions","optional":true}
    ]
    bind_operation :structuredClone, return_type: 'any', args: [
      {"name":"value","type":"any","optional":false},
      {"name":"options","type":"StructuredSerializeOptions","optional":true}
    ]
  end

  class DOMParser < Prism::Binding
    include Prism::BindingHelpers

    # def initialize()
    # end

    bind_operation :parseFromString, return_type: 'Document', args: [
      {"name":"string","type":"DOMString","optional":false},
      {"name":"type","type":"DOMParserSupportedType","optional":false}
    ]
  end

  # Skipped definition, name=DOMParserSupportedType, type='enum':
  # {
  #   "type": "enum",
  #   "name": "DOMParserSupportedType",
  #   "values": [
  #     {
  #       "type": "enum-value",
  #       "value": "text/html"
  #     },
  #     {
  #       "type": "enum-value",
  #       "value": "text/xml"
  #     },
  #     {
  #       "type": "enum-value",
  #       "value": "application/xml"
  #     },
  #     {
  #       "type": "enum-value",
  #       "value": "application/xhtml+xml"
  #     },
  #     {
  #       "type": "enum-value",
  #       "value": "image/svg+xml"
  #     }
  #   ],
  #   "extAttrs": []
  # }

  class Navigator < Prism::Binding
    include Prism::BindingHelpers


  end

  module NavigatorID
    include Prism::BindingHelpers

    bind_attr_reader :appCodeName, return_type: 'DOMString'
    bind_attr_reader :appName, return_type: 'DOMString'
    bind_attr_reader :appVersion, return_type: 'DOMString'
    bind_attr_reader :platform, return_type: 'DOMString'
    bind_attr_reader :product, return_type: 'DOMString'
    bind_attr_reader :productSub, return_type: 'DOMString'
    bind_attr_reader :userAgent, return_type: 'DOMString'
    bind_attr_reader :vendor, return_type: 'DOMString'
    bind_attr_reader :vendorSub, return_type: 'DOMString'
  end

  module NavigatorID
    include Prism::BindingHelpers

    bind_attr_reader :oscpu, return_type: 'DOMString'

    bind_operation :taintEnabled, return_type: 'boolean', args: []
  end

  module NavigatorLanguage
    include Prism::BindingHelpers

    bind_attr_reader :language, return_type: 'DOMString'
    bind_attr_reader :languages, return_type: '{
      "type": "attribute",
      "name": "languages",
      "idlType": {
        "type": "attribute-type",
        "extAttrs": [],
        "generic": "FrozenArray",
        "nullable": false,
        "union": false,
        "idlType": [
          {
            "type": "attribute-type",
            "extAttrs": [],
            "generic": "",
            "nullable": false,
            "union": false,
            "idlType": "DOMString"
          }
        ]
      },
      "extAttrs": [],
      "special": "",
      "readonly": true
    }'
  end

  module NavigatorOnLine
    include Prism::BindingHelpers

    bind_attr_reader :onLine, return_type: 'boolean'
  end

  module NavigatorContentUtils
    include Prism::BindingHelpers

    bind_operation :registerProtocolHandler, return_type: 'undefined', args: [
      {"name":"scheme","type":"DOMString","optional":false},
      {"name":"url","type":"USVString","optional":false}
    ]
    bind_operation :unregisterProtocolHandler, return_type: 'undefined', args: [
      {"name":"scheme","type":"DOMString","optional":false},
      {"name":"url","type":"USVString","optional":false}
    ]
  end

  module NavigatorCookies
    include Prism::BindingHelpers

    bind_attr_reader :cookieEnabled, return_type: 'boolean'
  end

  module NavigatorPlugins
    include Prism::BindingHelpers

    bind_attr_reader :plugins, return_type: 'PluginArray'
    bind_attr_reader :mimeTypes, return_type: 'MimeTypeArray'
    bind_attr_reader :pdfViewerEnabled, return_type: 'boolean'

    bind_operation :javaEnabled, return_type: 'boolean', args: []
  end

  class PluginArray < Prism::Binding
    include Prism::BindingHelpers

    bind_attr_reader :length, return_type: 'unsigned long'

    bind_operation :refresh, return_type: 'undefined', args: []
    bind_operation :item, return_type: 'Plugin', args: [
      {"name":"index","type":"unsigned long","optional":false}
    ]
    bind_operation :namedItem, return_type: 'Plugin', args: [
      {"name":"name","type":"DOMString","optional":false}
    ]
  end

  class MimeTypeArray < Prism::Binding
    include Prism::BindingHelpers

    bind_attr_reader :length, return_type: 'unsigned long'

    bind_operation :item, return_type: 'MimeType', args: [
      {"name":"index","type":"unsigned long","optional":false}
    ]
    bind_operation :namedItem, return_type: 'MimeType', args: [
      {"name":"name","type":"DOMString","optional":false}
    ]
  end

  class Plugin < Prism::Binding
    include Prism::BindingHelpers

    bind_attr_reader :name, return_type: 'DOMString'
    bind_attr_reader :description, return_type: 'DOMString'
    bind_attr_reader :filename, return_type: 'DOMString'
    bind_attr_reader :length, return_type: 'unsigned long'

    bind_operation :item, return_type: 'MimeType', args: [
      {"name":"index","type":"unsigned long","optional":false}
    ]
    bind_operation :namedItem, return_type: 'MimeType', args: [
      {"name":"name","type":"DOMString","optional":false}
    ]
  end

  class MimeType < Prism::Binding
    include Prism::BindingHelpers

    bind_attr_reader :type, return_type: 'DOMString'
    bind_attr_reader :description, return_type: 'DOMString'
    bind_attr_reader :suffixes, return_type: 'DOMString'
    bind_attr_reader :enabledPlugin, return_type: 'Plugin'
  end

  class ImageBitmap < Prism::Binding
    include Prism::BindingHelpers

    bind_attr_reader :width, return_type: 'unsigned long'
    bind_attr_reader :height, return_type: 'unsigned long'

    bind_operation :close, return_type: 'undefined', args: []
  end

  ImageBitmapSource = TypeDef.new("ImageBitmapSource", types: ["CanvasImageSource","Blob","ImageData"])

  # Skipped definition, name=ImageOrientation, type='enum':
  # {
  #   "type": "enum",
  #   "name": "ImageOrientation",
  #   "values": [
  #     {
  #       "type": "enum-value",
  #       "value": "none"
  #     },
  #     {
  #       "type": "enum-value",
  #       "value": "flipY"
  #     }
  #   ],
  #   "extAttrs": []
  # }

  # Skipped definition, name=PremultiplyAlpha, type='enum':
  # {
  #   "type": "enum",
  #   "name": "PremultiplyAlpha",
  #   "values": [
  #     {
  #       "type": "enum-value",
  #       "value": "none"
  #     },
  #     {
  #       "type": "enum-value",
  #       "value": "premultiply"
  #     },
  #     {
  #       "type": "enum-value",
  #       "value": "default"
  #     }
  #   ],
  #   "extAttrs": []
  # }

  # Skipped definition, name=ColorSpaceConversion, type='enum':
  # {
  #   "type": "enum",
  #   "name": "ColorSpaceConversion",
  #   "values": [
  #     {
  #       "type": "enum-value",
  #       "value": "none"
  #     },
  #     {
  #       "type": "enum-value",
  #       "value": "default"
  #     }
  #   ],
  #   "extAttrs": []
  # }

  # Skipped definition, name=ResizeQuality, type='enum':
  # {
  #   "type": "enum",
  #   "name": "ResizeQuality",
  #   "values": [
  #     {
  #       "type": "enum-value",
  #       "value": "pixelated"
  #     },
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

  # Skipped definition, name=ImageBitmapOptions, type='dictionary':
  # {
  #   "type": "dictionary",
  #   "name": "ImageBitmapOptions",
  #   "inheritance": null,
  #   "members": [
  #     {
  #       "type": "field",
  #       "name": "imageOrientation",
  #       "extAttrs": [],
  #       "idlType": {
  #         "type": "dictionary-type",
  #         "extAttrs": [],
  #         "generic": "",
  #         "nullable": false,
  #         "union": false,
  #         "idlType": "ImageOrientation"
  #       },
  #       "default": {
  #         "type": "string",
  #         "value": "none"
  #       },
  #       "required": false
  #     },
  #     {
  #       "type": "field",
  #       "name": "premultiplyAlpha",
  #       "extAttrs": [],
  #       "idlType": {
  #         "type": "dictionary-type",
  #         "extAttrs": [],
  #         "generic": "",
  #         "nullable": false,
  #         "union": false,
  #         "idlType": "PremultiplyAlpha"
  #       },
  #       "default": {
  #         "type": "string",
  #         "value": "default"
  #       },
  #       "required": false
  #     },
  #     {
  #       "type": "field",
  #       "name": "colorSpaceConversion",
  #       "extAttrs": [],
  #       "idlType": {
  #         "type": "dictionary-type",
  #         "extAttrs": [],
  #         "generic": "",
  #         "nullable": false,
  #         "union": false,
  #         "idlType": "ColorSpaceConversion"
  #       },
  #       "default": {
  #         "type": "string",
  #         "value": "default"
  #       },
  #       "required": false
  #     },
  #     {
  #       "type": "field",
  #       "name": "resizeWidth",
  #       "extAttrs": [
  #         {
  #           "type": "extended-attribute",
  #           "name": "EnforceRange",
  #           "rhs": null,
  #           "arguments": []
  #         }
  #       ],
  #       "idlType": {
  #         "type": "dictionary-type",
  #         "extAttrs": [],
  #         "generic": "",
  #         "nullable": false,
  #         "union": false,
  #         "idlType": "unsigned long"
  #       },
  #       "default": null,
  #       "required": false
  #     },
  #     {
  #       "type": "field",
  #       "name": "resizeHeight",
  #       "extAttrs": [
  #         {
  #           "type": "extended-attribute",
  #           "name": "EnforceRange",
  #           "rhs": null,
  #           "arguments": []
  #         }
  #       ],
  #       "idlType": {
  #         "type": "dictionary-type",
  #         "extAttrs": [],
  #         "generic": "",
  #         "nullable": false,
  #         "union": false,
  #         "idlType": "unsigned long"
  #       },
  #       "default": null,
  #       "required": false
  #     },
  #     {
  #       "type": "field",
  #       "name": "resizeQuality",
  #       "extAttrs": [],
  #       "idlType": {
  #         "type": "dictionary-type",
  #         "extAttrs": [],
  #         "generic": "",
  #         "nullable": false,
  #         "union": false,
  #         "idlType": "ResizeQuality"
  #       },
  #       "default": {
  #         "type": "string",
  #         "value": "low"
  #       },
  #       "required": false
  #     }
  #   ],
  #   "extAttrs": [],
  #   "partial": false
  # }

  FrameRequestCallback = CallbackInterface.new("FrameRequestCallback", args: [
    {"name":"time","type":"DOMHighResTimeStamp","optional":false}
  ])

  module AnimationFrameProvider
    include Prism::BindingHelpers

    bind_operation :requestAnimationFrame, return_type: 'unsigned long', args: [
      {"name":"callback","type":"FrameRequestCallback","optional":false}
    ]
    bind_operation :cancelAnimationFrame, return_type: 'undefined', args: [
      {"name":"handle","type":"unsigned long","optional":false}
    ]
  end

  class MessageEvent < Event
    include Prism::BindingHelpers

    # def initialize(type, eventInitDict = UNDEFINED)
    # end

    bind_attr_reader :data, return_type: 'any'
    bind_attr_reader :origin, return_type: 'USVString'
    bind_attr_reader :lastEventId, return_type: 'DOMString'
    bind_attr_reader :source, return_type: 'MessageEventSource'
    bind_attr_reader :ports, return_type: '{
      "type": "attribute",
      "name": "ports",
      "idlType": {
        "type": "attribute-type",
        "extAttrs": [],
        "generic": "FrozenArray",
        "nullable": false,
        "union": false,
        "idlType": [
          {
            "type": "attribute-type",
            "extAttrs": [],
            "generic": "",
            "nullable": false,
            "union": false,
            "idlType": "MessagePort"
          }
        ]
      },
      "extAttrs": [],
      "special": "",
      "readonly": true
    }'

    bind_operation :initMessageEvent, return_type: 'undefined', args: [
      {"name":"type","type":"DOMString","optional":false},
      {"name":"bubbles","type":"boolean","optional":true},
      {"name":"cancelable","type":"boolean","optional":true},
      {"name":"data","type":"any","optional":true},
      {"name":"origin","type":"USVString","optional":true},
      {"name":"lastEventId","type":"DOMString","optional":true},
      {"name":"source","type":"MessageEventSource","optional":true},
      {"name":"ports","type":"MessagePort","optional":true}
    ]
  end

  # Skipped definition, name=MessageEventInit, type='dictionary':
  # {
  #   "type": "dictionary",
  #   "name": "MessageEventInit",
  #   "inheritance": "EventInit",
  #   "members": [
  #     {
  #       "type": "field",
  #       "name": "data",
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
  #     },
  #     {
  #       "type": "field",
  #       "name": "origin",
  #       "extAttrs": [],
  #       "idlType": {
  #         "type": "dictionary-type",
  #         "extAttrs": [],
  #         "generic": "",
  #         "nullable": false,
  #         "union": false,
  #         "idlType": "USVString"
  #       },
  #       "default": {
  #         "type": "string",
  #         "value": ""
  #       },
  #       "required": false
  #     },
  #     {
  #       "type": "field",
  #       "name": "lastEventId",
  #       "extAttrs": [],
  #       "idlType": {
  #         "type": "dictionary-type",
  #         "extAttrs": [],
  #         "generic": "",
  #         "nullable": false,
  #         "union": false,
  #         "idlType": "DOMString"
  #       },
  #       "default": {
  #         "type": "string",
  #         "value": ""
  #       },
  #       "required": false
  #     },
  #     {
  #       "type": "field",
  #       "name": "source",
  #       "extAttrs": [],
  #       "idlType": {
  #         "type": "dictionary-type",
  #         "extAttrs": [],
  #         "generic": "",
  #         "nullable": true,
  #         "union": false,
  #         "idlType": "MessageEventSource"
  #       },
  #       "default": {
  #         "type": "null"
  #       },
  #       "required": false
  #     },
  #     {
  #       "type": "field",
  #       "name": "ports",
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
  #             "idlType": "MessagePort"
  #           }
  #         ]
  #       },
  #       "default": {
  #         "type": "sequence",
  #         "value": []
  #       },
  #       "required": false
  #     }
  #   ],
  #   "extAttrs": [],
  #   "partial": false
  # }

  MessageEventSource = TypeDef.new("MessageEventSource", types: ["WindowProxy","MessagePort","ServiceWorker"])

  class EventSource < EventTarget
    include Prism::BindingHelpers

    # def initialize(url, eventSourceInitDict = UNDEFINED)
    # end

    CONNECTING = 0
    OPEN = 1
    CLOSED = 2

    bind_attr_reader :url, return_type: 'USVString'
    bind_attr_reader :withCredentials, return_type: 'boolean'
    bind_attr_reader :readyState, return_type: 'unsigned short'

    bind_attr_accessor :onopen, return_type: 'EventHandler'
    bind_attr_accessor :onmessage, return_type: 'EventHandler'
    bind_attr_accessor :onerror, return_type: 'EventHandler'

    bind_operation :close, return_type: 'undefined', args: []
  end

  # Skipped definition, name=EventSourceInit, type='dictionary':
  # {
  #   "type": "dictionary",
  #   "name": "EventSourceInit",
  #   "inheritance": null,
  #   "members": [
  #     {
  #       "type": "field",
  #       "name": "withCredentials",
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

  # Skipped definition, name=BinaryType, type='enum':
  # {
  #   "type": "enum",
  #   "name": "BinaryType",
  #   "values": [
  #     {
  #       "type": "enum-value",
  #       "value": "blob"
  #     },
  #     {
  #       "type": "enum-value",
  #       "value": "arraybuffer"
  #     }
  #   ],
  #   "extAttrs": []
  # }

  class WebSocket < EventTarget
    include Prism::BindingHelpers

    # def initialize(url, protocols = UNDEFINED)
    # end

    CONNECTING = 0
    OPEN = 1
    CLOSING = 2
    CLOSED = 3

    bind_attr_reader :url, return_type: 'USVString'
    bind_attr_reader :readyState, return_type: 'unsigned short'
    bind_attr_reader :bufferedAmount, return_type: 'unsigned long long'
    bind_attr_reader :extensions, return_type: 'DOMString'
    bind_attr_reader :protocol, return_type: 'DOMString'

    bind_attr_accessor :onopen, return_type: 'EventHandler'
    bind_attr_accessor :onerror, return_type: 'EventHandler'
    bind_attr_accessor :onclose, return_type: 'EventHandler'
    bind_attr_accessor :onmessage, return_type: 'EventHandler'
    bind_attr_accessor :binaryType, return_type: 'BinaryType'

    bind_operation :close, return_type: 'undefined', args: [
      {"name":"code","type":"unsigned short","optional":true},
      {"name":"reason","type":"USVString","optional":true}
    ]
    bind_operation :send, return_type: 'undefined', args: [
      {"name":"data","type":"USVString","optional":false}
    ]
    bind_operation :send, return_type: 'undefined', args: [
      {"name":"data","type":"Blob","optional":false}
    ]
    bind_operation :send, return_type: 'undefined', args: [
      {"name":"data","type":"ArrayBuffer","optional":false}
    ]
    bind_operation :send, return_type: 'undefined', args: [
      {"name":"data","type":"ArrayBufferView","optional":false}
    ]
  end

  class CloseEvent < Event
    include Prism::BindingHelpers

    # def initialize(type, eventInitDict = UNDEFINED)
    # end

    bind_attr_reader :wasClean, return_type: 'boolean'
    bind_attr_reader :code, return_type: 'unsigned short'
    bind_attr_reader :reason, return_type: 'USVString'
  end

  # Skipped definition, name=CloseEventInit, type='dictionary':
  # {
  #   "type": "dictionary",
  #   "name": "CloseEventInit",
  #   "inheritance": "EventInit",
  #   "members": [
  #     {
  #       "type": "field",
  #       "name": "wasClean",
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
  #       "name": "code",
  #       "extAttrs": [],
  #       "idlType": {
  #         "type": "dictionary-type",
  #         "extAttrs": [],
  #         "generic": "",
  #         "nullable": false,
  #         "union": false,
  #         "idlType": "unsigned short"
  #       },
  #       "default": {
  #         "type": "number",
  #         "value": "0"
  #       },
  #       "required": false
  #     },
  #     {
  #       "type": "field",
  #       "name": "reason",
  #       "extAttrs": [],
  #       "idlType": {
  #         "type": "dictionary-type",
  #         "extAttrs": [],
  #         "generic": "",
  #         "nullable": false,
  #         "union": false,
  #         "idlType": "USVString"
  #       },
  #       "default": {
  #         "type": "string",
  #         "value": ""
  #       },
  #       "required": false
  #     }
  #   ],
  #   "extAttrs": [],
  #   "partial": false
  # }

  class MessageChannel < Prism::Binding
    include Prism::BindingHelpers

    # def initialize()
    # end

    bind_attr_reader :port1, return_type: 'MessagePort'
    bind_attr_reader :port2, return_type: 'MessagePort'
  end

  class MessagePort < EventTarget
    include Prism::BindingHelpers

    bind_attr_accessor :onmessage, return_type: 'EventHandler'
    bind_attr_accessor :onmessageerror, return_type: 'EventHandler'

    bind_operation :postMessage, return_type: 'undefined', args: [
      {"name":"message","type":"any","optional":false},
      {"name":"transfer","type":"object","optional":false}
    ]
    bind_operation :postMessage, return_type: 'undefined', args: [
      {"name":"message","type":"any","optional":false},
      {"name":"options","type":"StructuredSerializeOptions","optional":true}
    ]
    bind_operation :start, return_type: 'undefined', args: []
    bind_operation :close, return_type: 'undefined', args: []
  end

  # Skipped definition, name=StructuredSerializeOptions, type='dictionary':
  # {
  #   "type": "dictionary",
  #   "name": "StructuredSerializeOptions",
  #   "inheritance": null,
  #   "members": [
  #     {
  #       "type": "field",
  #       "name": "transfer",
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
  #             "idlType": "object"
  #           }
  #         ]
  #       },
  #       "default": {
  #         "type": "sequence",
  #         "value": []
  #       },
  #       "required": false
  #     }
  #   ],
  #   "extAttrs": [],
  #   "partial": false
  # }

  # Skipped definition, name=WindowPostMessageOptions, type='dictionary':
  # {
  #   "type": "dictionary",
  #   "name": "WindowPostMessageOptions",
  #   "inheritance": "StructuredSerializeOptions",
  #   "members": [
  #     {
  #       "type": "field",
  #       "name": "targetOrigin",
  #       "extAttrs": [],
  #       "idlType": {
  #         "type": "dictionary-type",
  #         "extAttrs": [],
  #         "generic": "",
  #         "nullable": false,
  #         "union": false,
  #         "idlType": "USVString"
  #       },
  #       "default": {
  #         "type": "string",
  #         "value": "/"
  #       },
  #       "required": false
  #     }
  #   ],
  #   "extAttrs": [],
  #   "partial": false
  # }

  class BroadcastChannel < EventTarget
    include Prism::BindingHelpers

    # def initialize(name)
    # end

    bind_attr_reader :name, return_type: 'DOMString'

    bind_attr_accessor :onmessage, return_type: 'EventHandler'
    bind_attr_accessor :onmessageerror, return_type: 'EventHandler'

    bind_operation :postMessage, return_type: 'undefined', args: [
      {"name":"message","type":"any","optional":false}
    ]
    bind_operation :close, return_type: 'undefined', args: []
  end

  class WorkerGlobalScope < EventTarget
    include Prism::BindingHelpers

    bind_attr_reader :self, return_type: 'WorkerGlobalScope'
    bind_attr_reader :location, return_type: 'WorkerLocation'
    bind_attr_reader :navigator, return_type: 'WorkerNavigator'

    bind_attr_accessor :onerror, return_type: 'OnErrorEventHandler'
    bind_attr_accessor :onlanguagechange, return_type: 'EventHandler'
    bind_attr_accessor :onoffline, return_type: 'EventHandler'
    bind_attr_accessor :ononline, return_type: 'EventHandler'
    bind_attr_accessor :onrejectionhandled, return_type: 'EventHandler'
    bind_attr_accessor :onunhandledrejection, return_type: 'EventHandler'

    bind_operation :importScripts, return_type: 'undefined', args: [
      {"name":"urls","type":"USVString","optional":false}
    ]
  end

  class DedicatedWorkerGlobalScope < WorkerGlobalScope
    include Prism::BindingHelpers

    bind_attr_reader :name, return_type: 'DOMString'

    bind_attr_accessor :onmessage, return_type: 'EventHandler'
    bind_attr_accessor :onmessageerror, return_type: 'EventHandler'

    bind_operation :postMessage, return_type: 'undefined', args: [
      {"name":"message","type":"any","optional":false},
      {"name":"transfer","type":"object","optional":false}
    ]
    bind_operation :postMessage, return_type: 'undefined', args: [
      {"name":"message","type":"any","optional":false},
      {"name":"options","type":"StructuredSerializeOptions","optional":true}
    ]
    bind_operation :close, return_type: 'undefined', args: []
  end

  class SharedWorkerGlobalScope < WorkerGlobalScope
    include Prism::BindingHelpers

    bind_attr_reader :name, return_type: 'DOMString'

    bind_attr_accessor :onconnect, return_type: 'EventHandler'

    bind_operation :close, return_type: 'undefined', args: []
  end

  module AbstractWorker
    include Prism::BindingHelpers

    bind_attr_accessor :onerror, return_type: 'EventHandler'
  end

  class Worker < EventTarget
    include Prism::BindingHelpers

    # def initialize(scriptURL, options = UNDEFINED)
    # end

    bind_attr_accessor :onmessage, return_type: 'EventHandler'
    bind_attr_accessor :onmessageerror, return_type: 'EventHandler'

    bind_operation :terminate, return_type: 'undefined', args: []
    bind_operation :postMessage, return_type: 'undefined', args: [
      {"name":"message","type":"any","optional":false},
      {"name":"transfer","type":"object","optional":false}
    ]
    bind_operation :postMessage, return_type: 'undefined', args: [
      {"name":"message","type":"any","optional":false},
      {"name":"options","type":"StructuredSerializeOptions","optional":true}
    ]
  end

  # Skipped definition, name=WorkerOptions, type='dictionary':
  # {
  #   "type": "dictionary",
  #   "name": "WorkerOptions",
  #   "inheritance": null,
  #   "members": [
  #     {
  #       "type": "field",
  #       "name": "type",
  #       "extAttrs": [],
  #       "idlType": {
  #         "type": "dictionary-type",
  #         "extAttrs": [],
  #         "generic": "",
  #         "nullable": false,
  #         "union": false,
  #         "idlType": "WorkerType"
  #       },
  #       "default": {
  #         "type": "string",
  #         "value": "classic"
  #       },
  #       "required": false
  #     },
  #     {
  #       "type": "field",
  #       "name": "credentials",
  #       "extAttrs": [],
  #       "idlType": {
  #         "type": "dictionary-type",
  #         "extAttrs": [],
  #         "generic": "",
  #         "nullable": false,
  #         "union": false,
  #         "idlType": "RequestCredentials"
  #       },
  #       "default": {
  #         "type": "string",
  #         "value": "same-origin"
  #       },
  #       "required": false
  #     },
  #     {
  #       "type": "field",
  #       "name": "name",
  #       "extAttrs": [],
  #       "idlType": {
  #         "type": "dictionary-type",
  #         "extAttrs": [],
  #         "generic": "",
  #         "nullable": false,
  #         "union": false,
  #         "idlType": "DOMString"
  #       },
  #       "default": {
  #         "type": "string",
  #         "value": ""
  #       },
  #       "required": false
  #     }
  #   ],
  #   "extAttrs": [],
  #   "partial": false
  # }

  # Skipped definition, name=WorkerType, type='enum':
  # {
  #   "type": "enum",
  #   "name": "WorkerType",
  #   "values": [
  #     {
  #       "type": "enum-value",
  #       "value": "classic"
  #     },
  #     {
  #       "type": "enum-value",
  #       "value": "module"
  #     }
  #   ],
  #   "extAttrs": []
  # }

  class SharedWorker < EventTarget
    include Prism::BindingHelpers

    # def initialize(scriptURL, options = UNDEFINED)
    # end

    bind_attr_reader :port, return_type: 'MessagePort'
  end

  module NavigatorConcurrentHardware
    include Prism::BindingHelpers

    bind_attr_reader :hardwareConcurrency, return_type: 'unsigned long long'
  end

  class WorkerNavigator < Prism::Binding
    include Prism::BindingHelpers


  end

  class WorkerLocation < Prism::Binding
    include Prism::BindingHelpers

    bind_attr_reader :href, return_type: 'DOMString'
    bind_attr_reader :origin, return_type: 'USVString'
    bind_attr_reader :protocol, return_type: 'USVString'
    bind_attr_reader :host, return_type: 'USVString'
    bind_attr_reader :hostname, return_type: 'USVString'
    bind_attr_reader :port, return_type: 'USVString'
    bind_attr_reader :pathname, return_type: 'USVString'
    bind_attr_reader :search, return_type: 'USVString'
    bind_attr_reader :hash, return_type: 'USVString'
  end

  class WorkletGlobalScope < Prism::Binding
    include Prism::BindingHelpers


  end

  class Worklet < Prism::Binding
    include Prism::BindingHelpers

    bind_operation :addModule, return_type: 'undefined', args: [
      {"name":"moduleURL","type":"USVString","optional":false},
      {"name":"options","type":"WorkletOptions","optional":true}
    ]
  end

  # Skipped definition, name=WorkletOptions, type='dictionary':
  # {
  #   "type": "dictionary",
  #   "name": "WorkletOptions",
  #   "inheritance": null,
  #   "members": [
  #     {
  #       "type": "field",
  #       "name": "credentials",
  #       "extAttrs": [],
  #       "idlType": {
  #         "type": "dictionary-type",
  #         "extAttrs": [],
  #         "generic": "",
  #         "nullable": false,
  #         "union": false,
  #         "idlType": "RequestCredentials"
  #       },
  #       "default": {
  #         "type": "string",
  #         "value": "same-origin"
  #       },
  #       "required": false
  #     }
  #   ],
  #   "extAttrs": [],
  #   "partial": false
  # }

  class Storage < Prism::Binding
    include Prism::BindingHelpers

    bind_attr_reader :length, return_type: 'unsigned long'

    bind_operation :key, return_type: 'DOMString', args: [
      {"name":"index","type":"unsigned long","optional":false}
    ]
    bind_operation :getItem, return_type: 'DOMString', args: [
      {"name":"key","type":"DOMString","optional":false}
    ]
    bind_operation :setItem, return_type: 'undefined', args: [
      {"name":"key","type":"DOMString","optional":false},
      {"name":"value","type":"DOMString","optional":false}
    ]
    bind_operation :_delete, return_type: 'undefined', args: [
      {"name":"key","type":"DOMString","optional":false}
    ]
    bind_operation :clear, return_type: 'undefined', args: []
  end

  module WindowSessionStorage
    include Prism::BindingHelpers

    bind_attr_reader :sessionStorage, return_type: 'Storage'
  end

  module WindowLocalStorage
    include Prism::BindingHelpers

    bind_attr_reader :localStorage, return_type: 'Storage'
  end

  class StorageEvent < Event
    include Prism::BindingHelpers

    # def initialize(type, eventInitDict = UNDEFINED)
    # end

    bind_attr_reader :key, return_type: 'DOMString'
    bind_attr_reader :oldValue, return_type: 'DOMString'
    bind_attr_reader :newValue, return_type: 'DOMString'
    bind_attr_reader :url, return_type: 'USVString'
    bind_attr_reader :storageArea, return_type: 'Storage'

    bind_operation :initStorageEvent, return_type: 'undefined', args: [
      {"name":"type","type":"DOMString","optional":false},
      {"name":"bubbles","type":"boolean","optional":true},
      {"name":"cancelable","type":"boolean","optional":true},
      {"name":"key","type":"DOMString","optional":true},
      {"name":"oldValue","type":"DOMString","optional":true},
      {"name":"newValue","type":"DOMString","optional":true},
      {"name":"url","type":"USVString","optional":true},
      {"name":"storageArea","type":"Storage","optional":true}
    ]
  end

  # Skipped definition, name=StorageEventInit, type='dictionary':
  # {
  #   "type": "dictionary",
  #   "name": "StorageEventInit",
  #   "inheritance": "EventInit",
  #   "members": [
  #     {
  #       "type": "field",
  #       "name": "key",
  #       "extAttrs": [],
  #       "idlType": {
  #         "type": "dictionary-type",
  #         "extAttrs": [],
  #         "generic": "",
  #         "nullable": true,
  #         "union": false,
  #         "idlType": "DOMString"
  #       },
  #       "default": {
  #         "type": "null"
  #       },
  #       "required": false
  #     },
  #     {
  #       "type": "field",
  #       "name": "oldValue",
  #       "extAttrs": [],
  #       "idlType": {
  #         "type": "dictionary-type",
  #         "extAttrs": [],
  #         "generic": "",
  #         "nullable": true,
  #         "union": false,
  #         "idlType": "DOMString"
  #       },
  #       "default": {
  #         "type": "null"
  #       },
  #       "required": false
  #     },
  #     {
  #       "type": "field",
  #       "name": "newValue",
  #       "extAttrs": [],
  #       "idlType": {
  #         "type": "dictionary-type",
  #         "extAttrs": [],
  #         "generic": "",
  #         "nullable": true,
  #         "union": false,
  #         "idlType": "DOMString"
  #       },
  #       "default": {
  #         "type": "null"
  #       },
  #       "required": false
  #     },
  #     {
  #       "type": "field",
  #       "name": "url",
  #       "extAttrs": [],
  #       "idlType": {
  #         "type": "dictionary-type",
  #         "extAttrs": [],
  #         "generic": "",
  #         "nullable": false,
  #         "union": false,
  #         "idlType": "USVString"
  #       },
  #       "default": {
  #         "type": "string",
  #         "value": ""
  #       },
  #       "required": false
  #     },
  #     {
  #       "type": "field",
  #       "name": "storageArea",
  #       "extAttrs": [],
  #       "idlType": {
  #         "type": "dictionary-type",
  #         "extAttrs": [],
  #         "generic": "",
  #         "nullable": true,
  #         "union": false,
  #         "idlType": "Storage"
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

  class HTMLMarqueeElement < HTMLElement
    include Prism::BindingHelpers

    # def initialize()
    # end

    bind_attr_accessor :behavior, return_type: 'DOMString'
    bind_attr_accessor :bgColor, return_type: 'DOMString'
    bind_attr_accessor :direction, return_type: 'DOMString'
    bind_attr_accessor :height, return_type: 'DOMString'
    bind_attr_accessor :hspace, return_type: 'unsigned long'
    bind_attr_accessor :loop, return_type: 'long'
    bind_attr_accessor :scrollAmount, return_type: 'unsigned long'
    bind_attr_accessor :scrollDelay, return_type: 'unsigned long'
    bind_attr_accessor :trueSpeed, return_type: 'boolean'
    bind_attr_accessor :vspace, return_type: 'unsigned long'
    bind_attr_accessor :width, return_type: 'DOMString'

    bind_operation :start, return_type: 'undefined', args: []
    bind_operation :stop, return_type: 'undefined', args: []
  end

  class HTMLFrameSetElement < HTMLElement
    include Prism::BindingHelpers

    # def initialize()
    # end

    bind_attr_accessor :cols, return_type: 'DOMString'
    bind_attr_accessor :rows, return_type: 'DOMString'
  end

  class HTMLFrameElement < HTMLElement
    include Prism::BindingHelpers

    # def initialize()
    # end

    bind_attr_reader :contentDocument, return_type: 'Document'
    bind_attr_reader :contentWindow, return_type: 'WindowProxy'

    bind_attr_accessor :name, return_type: 'DOMString'
    bind_attr_accessor :scrolling, return_type: 'DOMString'
    bind_attr_accessor :src, return_type: 'USVString'
    bind_attr_accessor :frameBorder, return_type: 'DOMString'
    bind_attr_accessor :longDesc, return_type: 'USVString'
    bind_attr_accessor :noResize, return_type: 'boolean'
    bind_attr_accessor :marginHeight, return_type: 'DOMString'
    bind_attr_accessor :marginWidth, return_type: 'DOMString'
  end

  class HTMLAnchorElement
    include Prism::BindingHelpers

    bind_attr_accessor :coords, return_type: 'DOMString'
    bind_attr_accessor :charset, return_type: 'DOMString'
    bind_attr_accessor :name, return_type: 'DOMString'
    bind_attr_accessor :rev, return_type: 'DOMString'
    bind_attr_accessor :shape, return_type: 'DOMString'
  end

  class HTMLAreaElement
    include Prism::BindingHelpers

    bind_attr_accessor :noHref, return_type: 'boolean'
  end

  class HTMLBodyElement
    include Prism::BindingHelpers

    bind_attr_accessor :text, return_type: 'DOMString'
    bind_attr_accessor :link, return_type: 'DOMString'
    bind_attr_accessor :vLink, return_type: 'DOMString'
    bind_attr_accessor :aLink, return_type: 'DOMString'
    bind_attr_accessor :bgColor, return_type: 'DOMString'
    bind_attr_accessor :background, return_type: 'DOMString'
  end

  class HTMLBRElement
    include Prism::BindingHelpers

    bind_attr_accessor :clear, return_type: 'DOMString'
  end

  class HTMLTableCaptionElement
    include Prism::BindingHelpers

    bind_attr_accessor :align, return_type: 'DOMString'
  end

  class HTMLTableColElement
    include Prism::BindingHelpers

    bind_attr_accessor :align, return_type: 'DOMString'
    bind_attr_accessor :ch, return_type: 'DOMString'
    bind_attr_accessor :chOff, return_type: 'DOMString'
    bind_attr_accessor :vAlign, return_type: 'DOMString'
    bind_attr_accessor :width, return_type: 'DOMString'
  end

  class HTMLDirectoryElement < HTMLElement
    include Prism::BindingHelpers

    # def initialize()
    # end

    bind_attr_accessor :compact, return_type: 'boolean'
  end

  class HTMLDivElement
    include Prism::BindingHelpers

    bind_attr_accessor :align, return_type: 'DOMString'
  end

  class HTMLDListElement
    include Prism::BindingHelpers

    bind_attr_accessor :compact, return_type: 'boolean'
  end

  class HTMLEmbedElement
    include Prism::BindingHelpers

    bind_attr_accessor :align, return_type: 'DOMString'
    bind_attr_accessor :name, return_type: 'DOMString'
  end

  class HTMLFontElement < HTMLElement
    include Prism::BindingHelpers

    # def initialize()
    # end

    bind_attr_accessor :color, return_type: 'DOMString'
    bind_attr_accessor :face, return_type: 'DOMString'
    bind_attr_accessor :size, return_type: 'DOMString'
  end

  class HTMLHeadingElement
    include Prism::BindingHelpers

    bind_attr_accessor :align, return_type: 'DOMString'
  end

  class HTMLHRElement
    include Prism::BindingHelpers

    bind_attr_accessor :align, return_type: 'DOMString'
    bind_attr_accessor :color, return_type: 'DOMString'
    bind_attr_accessor :noShade, return_type: 'boolean'
    bind_attr_accessor :size, return_type: 'DOMString'
    bind_attr_accessor :width, return_type: 'DOMString'
  end

  class HTMLHtmlElement
    include Prism::BindingHelpers

    bind_attr_accessor :version, return_type: 'DOMString'
  end

  class HTMLIFrameElement
    include Prism::BindingHelpers

    bind_attr_accessor :align, return_type: 'DOMString'
    bind_attr_accessor :scrolling, return_type: 'DOMString'
    bind_attr_accessor :frameBorder, return_type: 'DOMString'
    bind_attr_accessor :longDesc, return_type: 'USVString'
    bind_attr_accessor :marginHeight, return_type: 'DOMString'
    bind_attr_accessor :marginWidth, return_type: 'DOMString'
  end

  class HTMLImageElement
    include Prism::BindingHelpers

    bind_attr_accessor :name, return_type: 'DOMString'
    bind_attr_accessor :lowsrc, return_type: 'USVString'
    bind_attr_accessor :align, return_type: 'DOMString'
    bind_attr_accessor :hspace, return_type: 'unsigned long'
    bind_attr_accessor :vspace, return_type: 'unsigned long'
    bind_attr_accessor :longDesc, return_type: 'USVString'
    bind_attr_accessor :border, return_type: 'DOMString'
  end

  class HTMLInputElement
    include Prism::BindingHelpers

    bind_attr_accessor :align, return_type: 'DOMString'
    bind_attr_accessor :useMap, return_type: 'DOMString'
  end

  class HTMLLegendElement
    include Prism::BindingHelpers

    bind_attr_accessor :align, return_type: 'DOMString'
  end

  class HTMLLIElement
    include Prism::BindingHelpers

    bind_attr_accessor :type, return_type: 'DOMString'
  end

  class HTMLLinkElement
    include Prism::BindingHelpers

    bind_attr_accessor :charset, return_type: 'DOMString'
    bind_attr_accessor :rev, return_type: 'DOMString'
    bind_attr_accessor :target, return_type: 'DOMString'
  end

  class HTMLMenuElement
    include Prism::BindingHelpers

    bind_attr_accessor :compact, return_type: 'boolean'
  end

  class HTMLMetaElement
    include Prism::BindingHelpers

    bind_attr_accessor :scheme, return_type: 'DOMString'
  end

  class HTMLObjectElement
    include Prism::BindingHelpers

    bind_attr_accessor :align, return_type: 'DOMString'
    bind_attr_accessor :archive, return_type: 'DOMString'
    bind_attr_accessor :code, return_type: 'DOMString'
    bind_attr_accessor :declare, return_type: 'boolean'
    bind_attr_accessor :hspace, return_type: 'unsigned long'
    bind_attr_accessor :standby, return_type: 'DOMString'
    bind_attr_accessor :vspace, return_type: 'unsigned long'
    bind_attr_accessor :codeBase, return_type: 'DOMString'
    bind_attr_accessor :codeType, return_type: 'DOMString'
    bind_attr_accessor :useMap, return_type: 'DOMString'
    bind_attr_accessor :border, return_type: 'DOMString'
  end

  class HTMLOListElement
    include Prism::BindingHelpers

    bind_attr_accessor :compact, return_type: 'boolean'
  end

  class HTMLParagraphElement
    include Prism::BindingHelpers

    bind_attr_accessor :align, return_type: 'DOMString'
  end

  class HTMLParamElement
    include Prism::BindingHelpers

    bind_attr_accessor :type, return_type: 'DOMString'
    bind_attr_accessor :valueType, return_type: 'DOMString'
  end

  class HTMLPreElement
    include Prism::BindingHelpers

    bind_attr_accessor :width, return_type: 'long'
  end

  class HTMLStyleElement
    include Prism::BindingHelpers

    bind_attr_accessor :type, return_type: 'DOMString'
  end

  class HTMLScriptElement
    include Prism::BindingHelpers

    bind_attr_accessor :charset, return_type: 'DOMString'
    bind_attr_accessor :event, return_type: 'DOMString'
    bind_attr_accessor :htmlFor, return_type: 'DOMString'
  end

  class HTMLTableElement
    include Prism::BindingHelpers

    bind_attr_accessor :align, return_type: 'DOMString'
    bind_attr_accessor :border, return_type: 'DOMString'
    bind_attr_accessor :frame, return_type: 'DOMString'
    bind_attr_accessor :rules, return_type: 'DOMString'
    bind_attr_accessor :summary, return_type: 'DOMString'
    bind_attr_accessor :width, return_type: 'DOMString'
    bind_attr_accessor :bgColor, return_type: 'DOMString'
    bind_attr_accessor :cellPadding, return_type: 'DOMString'
    bind_attr_accessor :cellSpacing, return_type: 'DOMString'
  end

  class HTMLTableSectionElement
    include Prism::BindingHelpers

    bind_attr_accessor :align, return_type: 'DOMString'
    bind_attr_accessor :ch, return_type: 'DOMString'
    bind_attr_accessor :chOff, return_type: 'DOMString'
    bind_attr_accessor :vAlign, return_type: 'DOMString'
  end

  class HTMLTableCellElement
    include Prism::BindingHelpers

    bind_attr_accessor :align, return_type: 'DOMString'
    bind_attr_accessor :axis, return_type: 'DOMString'
    bind_attr_accessor :height, return_type: 'DOMString'
    bind_attr_accessor :width, return_type: 'DOMString'
    bind_attr_accessor :ch, return_type: 'DOMString'
    bind_attr_accessor :chOff, return_type: 'DOMString'
    bind_attr_accessor :noWrap, return_type: 'boolean'
    bind_attr_accessor :vAlign, return_type: 'DOMString'
    bind_attr_accessor :bgColor, return_type: 'DOMString'
  end

  class HTMLTableRowElement
    include Prism::BindingHelpers

    bind_attr_accessor :align, return_type: 'DOMString'
    bind_attr_accessor :ch, return_type: 'DOMString'
    bind_attr_accessor :chOff, return_type: 'DOMString'
    bind_attr_accessor :vAlign, return_type: 'DOMString'
    bind_attr_accessor :bgColor, return_type: 'DOMString'
  end

  class HTMLUListElement
    include Prism::BindingHelpers

    bind_attr_accessor :compact, return_type: 'boolean'
    bind_attr_accessor :type, return_type: 'DOMString'
  end

  class Document
    include Prism::BindingHelpers

    bind_attr_reader :anchors, return_type: 'HTMLCollection'
    bind_attr_reader :applets, return_type: 'HTMLCollection'
    bind_attr_reader :all, return_type: 'HTMLAllCollection'

    bind_attr_accessor :fgColor, return_type: 'DOMString'
    bind_attr_accessor :linkColor, return_type: 'DOMString'
    bind_attr_accessor :vlinkColor, return_type: 'DOMString'
    bind_attr_accessor :alinkColor, return_type: 'DOMString'
    bind_attr_accessor :bgColor, return_type: 'DOMString'

    bind_operation :clear, return_type: 'undefined', args: []
    bind_operation :captureEvents, return_type: 'undefined', args: []
    bind_operation :releaseEvents, return_type: 'undefined', args: []
  end

  class Window
    include Prism::BindingHelpers

    bind_attr_reader :external, return_type: 'External'

    bind_operation :captureEvents, return_type: 'undefined', args: []
    bind_operation :releaseEvents, return_type: 'undefined', args: []
  end

  class External < Prism::Binding
    include Prism::BindingHelpers

    bind_operation :AddSearchProvider, return_type: 'undefined', args: []
    bind_operation :IsSearchProviderInstalled, return_type: 'undefined', args: []
  end

  class XMLHttpRequestEventTarget < EventTarget
    include Prism::BindingHelpers

    bind_attr_accessor :onloadstart, return_type: 'EventHandler'
    bind_attr_accessor :onprogress, return_type: 'EventHandler'
    bind_attr_accessor :onabort, return_type: 'EventHandler'
    bind_attr_accessor :onerror, return_type: 'EventHandler'
    bind_attr_accessor :onload, return_type: 'EventHandler'
    bind_attr_accessor :ontimeout, return_type: 'EventHandler'
    bind_attr_accessor :onloadend, return_type: 'EventHandler'
  end

  class XMLHttpRequestUpload < XMLHttpRequestEventTarget
    include Prism::BindingHelpers


  end

  # Skipped definition, name=XMLHttpRequestResponseType, type='enum':
  # {
  #   "type": "enum",
  #   "name": "XMLHttpRequestResponseType",
  #   "values": [
  #     {
  #       "type": "enum-value",
  #       "value": ""
  #     },
  #     {
  #       "type": "enum-value",
  #       "value": "arraybuffer"
  #     },
  #     {
  #       "type": "enum-value",
  #       "value": "blob"
  #     },
  #     {
  #       "type": "enum-value",
  #       "value": "document"
  #     },
  #     {
  #       "type": "enum-value",
  #       "value": "json"
  #     },
  #     {
  #       "type": "enum-value",
  #       "value": "text"
  #     }
  #   ],
  #   "extAttrs": []
  # }

  class XMLHttpRequest < XMLHttpRequestEventTarget
    include Prism::BindingHelpers

    # def initialize()
    # end

    UNSENT = 0
    OPENED = 1
    HEADERS_RECEIVED = 2
    LOADING = 3
    DONE = 4

    bind_attr_reader :readyState, return_type: 'unsigned short'
    bind_attr_reader :upload, return_type: 'XMLHttpRequestUpload'
    bind_attr_reader :responseURL, return_type: 'USVString'
    bind_attr_reader :status, return_type: 'unsigned short'
    bind_attr_reader :statusText, return_type: 'ByteString'
    bind_attr_reader :response, return_type: 'any'
    bind_attr_reader :responseText, return_type: 'USVString'
    bind_attr_reader :responseXML, return_type: 'Document'

    bind_attr_accessor :onreadystatechange, return_type: 'EventHandler'
    bind_attr_accessor :timeout, return_type: 'unsigned long'
    bind_attr_accessor :withCredentials, return_type: 'boolean'
    bind_attr_accessor :responseType, return_type: 'XMLHttpRequestResponseType'

    bind_operation :open, return_type: 'undefined', args: [
      {"name":"method","type":"ByteString","optional":false},
      {"name":"url","type":"USVString","optional":false}
    ]
    bind_operation :open, return_type: 'undefined', args: [
      {"name":"method","type":"ByteString","optional":false},
      {"name":"url","type":"USVString","optional":false},
      {"name":"async","type":"boolean","optional":false},
      {"name":"username","type":"USVString","optional":true},
      {"name":"password","type":"USVString","optional":true}
    ]
    bind_operation :setRequestHeader, return_type: 'undefined', args: [
      {"name":"name","type":"ByteString","optional":false},
      {"name":"value","type":"ByteString","optional":false}
    ]
    bind_operation :send, return_type: 'undefined', args: [
      {"name":"body","type":"Document | XMLHttpRequestBodyInit","optional":true}
    ]
    bind_operation :abort, return_type: 'undefined', args: []
    bind_operation :getResponseHeader, return_type: 'ByteString', args: [
      {"name":"name","type":"ByteString","optional":false}
    ]
    bind_operation :getAllResponseHeaders, return_type: 'ByteString', args: []
    bind_operation :overrideMimeType, return_type: 'undefined', args: [
      {"name":"mime","type":"DOMString","optional":false}
    ]
  end

  FormDataEntryValue = TypeDef.new("FormDataEntryValue", types: ["File","USVString"])

  class FormData < Prism::Binding
    include Prism::BindingHelpers

    # def initialize(form = UNDEFINED)
    # end

    bind_operation :append, return_type: 'undefined', args: [
      {"name":"name","type":"USVString","optional":false},
      {"name":"value","type":"USVString","optional":false}
    ]
    bind_operation :append, return_type: 'undefined', args: [
      {"name":"name","type":"USVString","optional":false},
      {"name":"blobValue","type":"Blob","optional":false},
      {"name":"filename","type":"USVString","optional":true}
    ]
    bind_operation :delete, return_type: 'undefined', args: [
      {"name":"name","type":"USVString","optional":false}
    ]
    bind_operation :get, return_type: 'FormDataEntryValue', args: [
      {"name":"name","type":"USVString","optional":false}
    ]
    bind_operation :getAll, return_type: 'FormDataEntryValue', args: [
      {"name":"name","type":"USVString","optional":false}
    ]
    bind_operation :has, return_type: 'boolean', args: [
      {"name":"name","type":"USVString","optional":false}
    ]
    bind_operation :set, return_type: 'undefined', args: [
      {"name":"name","type":"USVString","optional":false},
      {"name":"value","type":"USVString","optional":false}
    ]
    bind_operation :set, return_type: 'undefined', args: [
      {"name":"name","type":"USVString","optional":false},
      {"name":"blobValue","type":"Blob","optional":false},
      {"name":"filename","type":"USVString","optional":true}
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
    #       "idlType": "USVString"
    #     },
    #     {
    #       "type": null,
    #       "extAttrs": [],
    #       "generic": "",
    #       "nullable": false,
    #       "union": false,
    #       "idlType": "FormDataEntryValue"
    #     }
    #   ],
    #   "arguments": [],
    #   "extAttrs": [],
    #   "readonly": false,
    #   "async": false
    # }
  end

  class ProgressEvent < Event
    include Prism::BindingHelpers

    # def initialize(type, eventInitDict = UNDEFINED)
    # end

    bind_attr_reader :lengthComputable, return_type: 'boolean'
    bind_attr_reader :loaded, return_type: 'unsigned long long'
    bind_attr_reader :total, return_type: 'unsigned long long'
  end

  # Skipped definition, name=ProgressEventInit, type='dictionary':
  # {
  #   "type": "dictionary",
  #   "name": "ProgressEventInit",
  #   "inheritance": "EventInit",
  #   "members": [
  #     {
  #       "type": "field",
  #       "name": "lengthComputable",
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
  #       "name": "loaded",
  #       "extAttrs": [],
  #       "idlType": {
  #         "type": "dictionary-type",
  #         "extAttrs": [],
  #         "generic": "",
  #         "nullable": false,
  #         "union": false,
  #         "idlType": "unsigned long long"
  #       },
  #       "default": {
  #         "type": "number",
  #         "value": "0"
  #       },
  #       "required": false
  #     },
  #     {
  #       "type": "field",
  #       "name": "total",
  #       "extAttrs": [],
  #       "idlType": {
  #         "type": "dictionary-type",
  #         "extAttrs": [],
  #         "generic": "",
  #         "nullable": false,
  #         "union": false,
  #         "idlType": "unsigned long long"
  #       },
  #       "default": {
  #         "type": "number",
  #         "value": "0"
  #       },
  #       "required": false
  #     }
  #   ],
  #   "extAttrs": [],
  #   "partial": false
  # }

  HeadersInit = TypeDef.new("HeadersInit", types: ["[object Object]","[object Object],[object Object]"])

  class Headers < Prism::Binding
    include Prism::BindingHelpers

    # def initialize(init = UNDEFINED)
    # end

    bind_operation :append, return_type: 'undefined', args: [
      {"name":"name","type":"ByteString","optional":false},
      {"name":"value","type":"ByteString","optional":false}
    ]
    bind_operation :delete, return_type: 'undefined', args: [
      {"name":"name","type":"ByteString","optional":false}
    ]
    bind_operation :get, return_type: 'ByteString', args: [
      {"name":"name","type":"ByteString","optional":false}
    ]
    bind_operation :has, return_type: 'boolean', args: [
      {"name":"name","type":"ByteString","optional":false}
    ]
    bind_operation :set, return_type: 'undefined', args: [
      {"name":"name","type":"ByteString","optional":false},
      {"name":"value","type":"ByteString","optional":false}
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
    #       "idlType": "ByteString"
    #     },
    #     {
    #       "type": null,
    #       "extAttrs": [],
    #       "generic": "",
    #       "nullable": false,
    #       "union": false,
    #       "idlType": "ByteString"
    #     }
    #   ],
    #   "arguments": [],
    #   "extAttrs": [],
    #   "readonly": false,
    #   "async": false
    # }
  end

  XMLHttpRequestBodyInit = TypeDef.new("XMLHttpRequestBodyInit", types: ["Blob","BufferSource","FormData","URLSearchParams","USVString"])

  BodyInit = TypeDef.new("BodyInit", types: ["ReadableStream","XMLHttpRequestBodyInit"])

  module Body
    include Prism::BindingHelpers

    bind_attr_reader :body, return_type: 'ReadableStream'
    bind_attr_reader :bodyUsed, return_type: 'boolean'

    bind_operation :arrayBuffer, return_type: 'ArrayBuffer', args: []
    bind_operation :blob, return_type: 'Blob', args: []
    bind_operation :formData, return_type: 'FormData', args: []
    bind_operation :json, return_type: 'any', args: []
    bind_operation :text, return_type: 'USVString', args: []
  end

  RequestInfo = TypeDef.new("RequestInfo", types: ["Request","USVString"])

  class Request < Prism::Binding
    include Prism::BindingHelpers

    # def initialize(input, init = UNDEFINED)
    # end

    bind_attr_reader :method, return_type: 'ByteString'
    bind_attr_reader :url, return_type: 'USVString'
    bind_attr_reader :headers, return_type: 'Headers'
    bind_attr_reader :destination, return_type: 'RequestDestination'
    bind_attr_reader :referrer, return_type: 'USVString'
    bind_attr_reader :referrerPolicy, return_type: 'ReferrerPolicy'
    bind_attr_reader :mode, return_type: 'RequestMode'
    bind_attr_reader :credentials, return_type: 'RequestCredentials'
    bind_attr_reader :cache, return_type: 'RequestCache'
    bind_attr_reader :redirect, return_type: 'RequestRedirect'
    bind_attr_reader :integrity, return_type: 'DOMString'
    bind_attr_reader :keepalive, return_type: 'boolean'
    bind_attr_reader :isReloadNavigation, return_type: 'boolean'
    bind_attr_reader :isHistoryNavigation, return_type: 'boolean'
    bind_attr_reader :signal, return_type: 'AbortSignal'

    bind_operation :clone, return_type: 'Request', args: []
  end

  # Skipped definition, name=RequestInit, type='dictionary':
  # {
  #   "type": "dictionary",
  #   "name": "RequestInit",
  #   "inheritance": null,
  #   "members": [
  #     {
  #       "type": "field",
  #       "name": "method",
  #       "extAttrs": [],
  #       "idlType": {
  #         "type": "dictionary-type",
  #         "extAttrs": [],
  #         "generic": "",
  #         "nullable": false,
  #         "union": false,
  #         "idlType": "ByteString"
  #       },
  #       "default": null,
  #       "required": false
  #     },
  #     {
  #       "type": "field",
  #       "name": "headers",
  #       "extAttrs": [],
  #       "idlType": {
  #         "type": "dictionary-type",
  #         "extAttrs": [],
  #         "generic": "",
  #         "nullable": false,
  #         "union": false,
  #         "idlType": "HeadersInit"
  #       },
  #       "default": null,
  #       "required": false
  #     },
  #     {
  #       "type": "field",
  #       "name": "body",
  #       "extAttrs": [],
  #       "idlType": {
  #         "type": "dictionary-type",
  #         "extAttrs": [],
  #         "generic": "",
  #         "nullable": true,
  #         "union": false,
  #         "idlType": "BodyInit"
  #       },
  #       "default": null,
  #       "required": false
  #     },
  #     {
  #       "type": "field",
  #       "name": "referrer",
  #       "extAttrs": [],
  #       "idlType": {
  #         "type": "dictionary-type",
  #         "extAttrs": [],
  #         "generic": "",
  #         "nullable": false,
  #         "union": false,
  #         "idlType": "USVString"
  #       },
  #       "default": null,
  #       "required": false
  #     },
  #     {
  #       "type": "field",
  #       "name": "referrerPolicy",
  #       "extAttrs": [],
  #       "idlType": {
  #         "type": "dictionary-type",
  #         "extAttrs": [],
  #         "generic": "",
  #         "nullable": false,
  #         "union": false,
  #         "idlType": "ReferrerPolicy"
  #       },
  #       "default": null,
  #       "required": false
  #     },
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
  #         "idlType": "RequestMode"
  #       },
  #       "default": null,
  #       "required": false
  #     },
  #     {
  #       "type": "field",
  #       "name": "credentials",
  #       "extAttrs": [],
  #       "idlType": {
  #         "type": "dictionary-type",
  #         "extAttrs": [],
  #         "generic": "",
  #         "nullable": false,
  #         "union": false,
  #         "idlType": "RequestCredentials"
  #       },
  #       "default": null,
  #       "required": false
  #     },
  #     {
  #       "type": "field",
  #       "name": "cache",
  #       "extAttrs": [],
  #       "idlType": {
  #         "type": "dictionary-type",
  #         "extAttrs": [],
  #         "generic": "",
  #         "nullable": false,
  #         "union": false,
  #         "idlType": "RequestCache"
  #       },
  #       "default": null,
  #       "required": false
  #     },
  #     {
  #       "type": "field",
  #       "name": "redirect",
  #       "extAttrs": [],
  #       "idlType": {
  #         "type": "dictionary-type",
  #         "extAttrs": [],
  #         "generic": "",
  #         "nullable": false,
  #         "union": false,
  #         "idlType": "RequestRedirect"
  #       },
  #       "default": null,
  #       "required": false
  #     },
  #     {
  #       "type": "field",
  #       "name": "integrity",
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
  #     },
  #     {
  #       "type": "field",
  #       "name": "keepalive",
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
  #       "name": "signal",
  #       "extAttrs": [],
  #       "idlType": {
  #         "type": "dictionary-type",
  #         "extAttrs": [],
  #         "generic": "",
  #         "nullable": true,
  #         "union": false,
  #         "idlType": "AbortSignal"
  #       },
  #       "default": null,
  #       "required": false
  #     },
  #     {
  #       "type": "field",
  #       "name": "window",
  #       "extAttrs": [],
  #       "idlType": {
  #         "type": "dictionary-type",
  #         "extAttrs": [],
  #         "generic": "",
  #         "nullable": false,
  #         "union": false,
  #         "idlType": "any"
  #       },
  #       "default": null,
  #       "required": false
  #     }
  #   ],
  #   "extAttrs": [],
  #   "partial": false
  # }

  # Skipped definition, name=RequestDestination, type='enum':
  # {
  #   "type": "enum",
  #   "name": "RequestDestination",
  #   "values": [
  #     {
  #       "type": "enum-value",
  #       "value": ""
  #     },
  #     {
  #       "type": "enum-value",
  #       "value": "audio"
  #     },
  #     {
  #       "type": "enum-value",
  #       "value": "audioworklet"
  #     },
  #     {
  #       "type": "enum-value",
  #       "value": "document"
  #     },
  #     {
  #       "type": "enum-value",
  #       "value": "embed"
  #     },
  #     {
  #       "type": "enum-value",
  #       "value": "font"
  #     },
  #     {
  #       "type": "enum-value",
  #       "value": "frame"
  #     },
  #     {
  #       "type": "enum-value",
  #       "value": "iframe"
  #     },
  #     {
  #       "type": "enum-value",
  #       "value": "image"
  #     },
  #     {
  #       "type": "enum-value",
  #       "value": "manifest"
  #     },
  #     {
  #       "type": "enum-value",
  #       "value": "object"
  #     },
  #     {
  #       "type": "enum-value",
  #       "value": "paintworklet"
  #     },
  #     {
  #       "type": "enum-value",
  #       "value": "report"
  #     },
  #     {
  #       "type": "enum-value",
  #       "value": "script"
  #     },
  #     {
  #       "type": "enum-value",
  #       "value": "sharedworker"
  #     },
  #     {
  #       "type": "enum-value",
  #       "value": "style"
  #     },
  #     {
  #       "type": "enum-value",
  #       "value": "track"
  #     },
  #     {
  #       "type": "enum-value",
  #       "value": "video"
  #     },
  #     {
  #       "type": "enum-value",
  #       "value": "worker"
  #     },
  #     {
  #       "type": "enum-value",
  #       "value": "xslt"
  #     }
  #   ],
  #   "extAttrs": []
  # }

  # Skipped definition, name=RequestMode, type='enum':
  # {
  #   "type": "enum",
  #   "name": "RequestMode",
  #   "values": [
  #     {
  #       "type": "enum-value",
  #       "value": "navigate"
  #     },
  #     {
  #       "type": "enum-value",
  #       "value": "same-origin"
  #     },
  #     {
  #       "type": "enum-value",
  #       "value": "no-cors"
  #     },
  #     {
  #       "type": "enum-value",
  #       "value": "cors"
  #     }
  #   ],
  #   "extAttrs": []
  # }

  # Skipped definition, name=RequestCredentials, type='enum':
  # {
  #   "type": "enum",
  #   "name": "RequestCredentials",
  #   "values": [
  #     {
  #       "type": "enum-value",
  #       "value": "omit"
  #     },
  #     {
  #       "type": "enum-value",
  #       "value": "same-origin"
  #     },
  #     {
  #       "type": "enum-value",
  #       "value": "include"
  #     }
  #   ],
  #   "extAttrs": []
  # }

  # Skipped definition, name=RequestCache, type='enum':
  # {
  #   "type": "enum",
  #   "name": "RequestCache",
  #   "values": [
  #     {
  #       "type": "enum-value",
  #       "value": "default"
  #     },
  #     {
  #       "type": "enum-value",
  #       "value": "no-store"
  #     },
  #     {
  #       "type": "enum-value",
  #       "value": "reload"
  #     },
  #     {
  #       "type": "enum-value",
  #       "value": "no-cache"
  #     },
  #     {
  #       "type": "enum-value",
  #       "value": "force-cache"
  #     },
  #     {
  #       "type": "enum-value",
  #       "value": "only-if-cached"
  #     }
  #   ],
  #   "extAttrs": []
  # }

  # Skipped definition, name=RequestRedirect, type='enum':
  # {
  #   "type": "enum",
  #   "name": "RequestRedirect",
  #   "values": [
  #     {
  #       "type": "enum-value",
  #       "value": "follow"
  #     },
  #     {
  #       "type": "enum-value",
  #       "value": "error"
  #     },
  #     {
  #       "type": "enum-value",
  #       "value": "manual"
  #     }
  #   ],
  #   "extAttrs": []
  # }

  class Response < Prism::Binding
    include Prism::BindingHelpers

    # def initialize(body = UNDEFINED, init = UNDEFINED)
    # end

    bind_attr_reader :type, return_type: 'ResponseType'
    bind_attr_reader :url, return_type: 'USVString'
    bind_attr_reader :redirected, return_type: 'boolean'
    bind_attr_reader :status, return_type: 'unsigned short'
    bind_attr_reader :ok, return_type: 'boolean'
    bind_attr_reader :statusText, return_type: 'ByteString'
    bind_attr_reader :headers, return_type: 'Headers'

    bind_operation :error, return_type: 'Response', args: []
    bind_operation :redirect, return_type: 'Response', args: [
      {"name":"url","type":"USVString","optional":false},
      {"name":"status","type":"unsigned short","optional":true}
    ]
    bind_operation :clone, return_type: 'Response', args: []
  end

  # Skipped definition, name=ResponseInit, type='dictionary':
  # {
  #   "type": "dictionary",
  #   "name": "ResponseInit",
  #   "inheritance": null,
  #   "members": [
  #     {
  #       "type": "field",
  #       "name": "status",
  #       "extAttrs": [],
  #       "idlType": {
  #         "type": "dictionary-type",
  #         "extAttrs": [],
  #         "generic": "",
  #         "nullable": false,
  #         "union": false,
  #         "idlType": "unsigned short"
  #       },
  #       "default": {
  #         "type": "number",
  #         "value": "200"
  #       },
  #       "required": false
  #     },
  #     {
  #       "type": "field",
  #       "name": "statusText",
  #       "extAttrs": [],
  #       "idlType": {
  #         "type": "dictionary-type",
  #         "extAttrs": [],
  #         "generic": "",
  #         "nullable": false,
  #         "union": false,
  #         "idlType": "ByteString"
  #       },
  #       "default": {
  #         "type": "string",
  #         "value": ""
  #       },
  #       "required": false
  #     },
  #     {
  #       "type": "field",
  #       "name": "headers",
  #       "extAttrs": [],
  #       "idlType": {
  #         "type": "dictionary-type",
  #         "extAttrs": [],
  #         "generic": "",
  #         "nullable": false,
  #         "union": false,
  #         "idlType": "HeadersInit"
  #       },
  #       "default": null,
  #       "required": false
  #     }
  #   ],
  #   "extAttrs": [],
  #   "partial": false
  # }

  # Skipped definition, name=ResponseType, type='enum':
  # {
  #   "type": "enum",
  #   "name": "ResponseType",
  #   "values": [
  #     {
  #       "type": "enum-value",
  #       "value": "basic"
  #     },
  #     {
  #       "type": "enum-value",
  #       "value": "cors"
  #     },
  #     {
  #       "type": "enum-value",
  #       "value": "default"
  #     },
  #     {
  #       "type": "enum-value",
  #       "value": "error"
  #     },
  #     {
  #       "type": "enum-value",
  #       "value": "opaque"
  #     },
  #     {
  #       "type": "enum-value",
  #       "value": "opaqueredirect"
  #     }
  #   ],
  #   "extAttrs": []
  # }

  module WindowOrWorkerGlobalScope
    include Prism::BindingHelpers

    bind_operation :fetch, return_type: 'Response', args: [
      {"name":"input","type":"RequestInfo","optional":false},
      {"name":"init","type":"RequestInit","optional":true}
    ]
  end

  class UIEvent < Event
    include Prism::BindingHelpers

    # def initialize(type, eventInitDict = UNDEFINED)
    # end

    bind_attr_reader :view, return_type: 'Window'
    bind_attr_reader :detail, return_type: 'long'
  end

  # Skipped definition, name=UIEventInit, type='dictionary':
  # {
  #   "type": "dictionary",
  #   "name": "UIEventInit",
  #   "inheritance": "EventInit",
  #   "members": [
  #     {
  #       "type": "field",
  #       "name": "view",
  #       "extAttrs": [],
  #       "idlType": {
  #         "type": "dictionary-type",
  #         "extAttrs": [],
  #         "generic": "",
  #         "nullable": true,
  #         "union": false,
  #         "idlType": "Window"
  #       },
  #       "default": {
  #         "type": "null"
  #       },
  #       "required": false
  #     },
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
  #         "idlType": "long"
  #       },
  #       "default": {
  #         "type": "number",
  #         "value": "0"
  #       },
  #       "required": false
  #     }
  #   ],
  #   "extAttrs": [],
  #   "partial": false
  # }

  class FocusEvent < UIEvent
    include Prism::BindingHelpers

    # def initialize(type, eventInitDict = UNDEFINED)
    # end

    bind_attr_reader :relatedTarget, return_type: 'EventTarget'
  end

  # Skipped definition, name=FocusEventInit, type='dictionary':
  # {
  #   "type": "dictionary",
  #   "name": "FocusEventInit",
  #   "inheritance": "UIEventInit",
  #   "members": [
  #     {
  #       "type": "field",
  #       "name": "relatedTarget",
  #       "extAttrs": [],
  #       "idlType": {
  #         "type": "dictionary-type",
  #         "extAttrs": [],
  #         "generic": "",
  #         "nullable": true,
  #         "union": false,
  #         "idlType": "EventTarget"
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

  class MouseEvent < UIEvent
    include Prism::BindingHelpers

    # def initialize(type, eventInitDict = UNDEFINED)
    # end

    bind_attr_reader :screenX, return_type: 'long'
    bind_attr_reader :screenY, return_type: 'long'
    bind_attr_reader :clientX, return_type: 'long'
    bind_attr_reader :clientY, return_type: 'long'
    bind_attr_reader :ctrlKey, return_type: 'boolean'
    bind_attr_reader :shiftKey, return_type: 'boolean'
    bind_attr_reader :altKey, return_type: 'boolean'
    bind_attr_reader :metaKey, return_type: 'boolean'
    bind_attr_reader :button, return_type: 'short'
    bind_attr_reader :buttons, return_type: 'unsigned short'
    bind_attr_reader :relatedTarget, return_type: 'EventTarget'

    bind_operation :getModifierState, return_type: 'boolean', args: [
      {"name":"keyArg","type":"DOMString","optional":false}
    ]
  end

  class DragEvent < MouseEvent
    include Prism::BindingHelpers

    # def initialize(type, eventInitDict = UNDEFINED)
    # end

    bind_attr_reader :dataTransfer, return_type: 'DataTransfer'
  end

  # Skipped definition, name=EventModifierInit, type='dictionary':
  # {
  #   "type": "dictionary",
  #   "name": "EventModifierInit",
  #   "inheritance": "UIEventInit",
  #   "members": [
  #     {
  #       "type": "field",
  #       "name": "ctrlKey",
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
  #       "name": "shiftKey",
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
  #       "name": "altKey",
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
  #       "name": "metaKey",
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
  #       "name": "modifierAltGraph",
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
  #       "name": "modifierCapsLock",
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
  #       "name": "modifierFn",
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
  #       "name": "modifierFnLock",
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
  #       "name": "modifierHyper",
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
  #       "name": "modifierNumLock",
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
  #       "name": "modifierScrollLock",
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
  #       "name": "modifierSuper",
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
  #       "name": "modifierSymbol",
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
  #       "name": "modifierSymbolLock",
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

  # Skipped definition, name=MouseEventInit, type='dictionary':
  # {
  #   "type": "dictionary",
  #   "name": "MouseEventInit",
  #   "inheritance": "EventModifierInit",
  #   "members": [
  #     {
  #       "type": "field",
  #       "name": "screenX",
  #       "extAttrs": [],
  #       "idlType": {
  #         "type": "dictionary-type",
  #         "extAttrs": [],
  #         "generic": "",
  #         "nullable": false,
  #         "union": false,
  #         "idlType": "long"
  #       },
  #       "default": {
  #         "type": "number",
  #         "value": "0"
  #       },
  #       "required": false
  #     },
  #     {
  #       "type": "field",
  #       "name": "screenY",
  #       "extAttrs": [],
  #       "idlType": {
  #         "type": "dictionary-type",
  #         "extAttrs": [],
  #         "generic": "",
  #         "nullable": false,
  #         "union": false,
  #         "idlType": "long"
  #       },
  #       "default": {
  #         "type": "number",
  #         "value": "0"
  #       },
  #       "required": false
  #     },
  #     {
  #       "type": "field",
  #       "name": "clientX",
  #       "extAttrs": [],
  #       "idlType": {
  #         "type": "dictionary-type",
  #         "extAttrs": [],
  #         "generic": "",
  #         "nullable": false,
  #         "union": false,
  #         "idlType": "long"
  #       },
  #       "default": {
  #         "type": "number",
  #         "value": "0"
  #       },
  #       "required": false
  #     },
  #     {
  #       "type": "field",
  #       "name": "clientY",
  #       "extAttrs": [],
  #       "idlType": {
  #         "type": "dictionary-type",
  #         "extAttrs": [],
  #         "generic": "",
  #         "nullable": false,
  #         "union": false,
  #         "idlType": "long"
  #       },
  #       "default": {
  #         "type": "number",
  #         "value": "0"
  #       },
  #       "required": false
  #     },
  #     {
  #       "type": "field",
  #       "name": "button",
  #       "extAttrs": [],
  #       "idlType": {
  #         "type": "dictionary-type",
  #         "extAttrs": [],
  #         "generic": "",
  #         "nullable": false,
  #         "union": false,
  #         "idlType": "short"
  #       },
  #       "default": {
  #         "type": "number",
  #         "value": "0"
  #       },
  #       "required": false
  #     },
  #     {
  #       "type": "field",
  #       "name": "buttons",
  #       "extAttrs": [],
  #       "idlType": {
  #         "type": "dictionary-type",
  #         "extAttrs": [],
  #         "generic": "",
  #         "nullable": false,
  #         "union": false,
  #         "idlType": "unsigned short"
  #       },
  #       "default": {
  #         "type": "number",
  #         "value": "0"
  #       },
  #       "required": false
  #     },
  #     {
  #       "type": "field",
  #       "name": "relatedTarget",
  #       "extAttrs": [],
  #       "idlType": {
  #         "type": "dictionary-type",
  #         "extAttrs": [],
  #         "generic": "",
  #         "nullable": true,
  #         "union": false,
  #         "idlType": "EventTarget"
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

  # Skipped definition, name=DragEventInit, type='dictionary':
  # {
  #   "type": "dictionary",
  #   "name": "DragEventInit",
  #   "inheritance": "MouseEventInit",
  #   "members": [
  #     {
  #       "type": "field",
  #       "name": "dataTransfer",
  #       "extAttrs": [],
  #       "idlType": {
  #         "type": "dictionary-type",
  #         "extAttrs": [],
  #         "generic": "",
  #         "nullable": true,
  #         "union": false,
  #         "idlType": "DataTransfer"
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

  class WheelEvent < MouseEvent
    include Prism::BindingHelpers

    # def initialize(type, eventInitDict = UNDEFINED)
    # end

    DOM_DELTA_PIXEL = 0x00
    DOM_DELTA_LINE = 0x01
    DOM_DELTA_PAGE = 0x02

    bind_attr_reader :deltaX, return_type: 'double'
    bind_attr_reader :deltaY, return_type: 'double'
    bind_attr_reader :deltaZ, return_type: 'double'
    bind_attr_reader :deltaMode, return_type: 'unsigned long'
  end

  # Skipped definition, name=WheelEventInit, type='dictionary':
  # {
  #   "type": "dictionary",
  #   "name": "WheelEventInit",
  #   "inheritance": "MouseEventInit",
  #   "members": [
  #     {
  #       "type": "field",
  #       "name": "deltaX",
  #       "extAttrs": [],
  #       "idlType": {
  #         "type": "dictionary-type",
  #         "extAttrs": [],
  #         "generic": "",
  #         "nullable": false,
  #         "union": false,
  #         "idlType": "double"
  #       },
  #       "default": {
  #         "type": "number",
  #         "value": "0.0"
  #       },
  #       "required": false
  #     },
  #     {
  #       "type": "field",
  #       "name": "deltaY",
  #       "extAttrs": [],
  #       "idlType": {
  #         "type": "dictionary-type",
  #         "extAttrs": [],
  #         "generic": "",
  #         "nullable": false,
  #         "union": false,
  #         "idlType": "double"
  #       },
  #       "default": {
  #         "type": "number",
  #         "value": "0.0"
  #       },
  #       "required": false
  #     },
  #     {
  #       "type": "field",
  #       "name": "deltaZ",
  #       "extAttrs": [],
  #       "idlType": {
  #         "type": "dictionary-type",
  #         "extAttrs": [],
  #         "generic": "",
  #         "nullable": false,
  #         "union": false,
  #         "idlType": "double"
  #       },
  #       "default": {
  #         "type": "number",
  #         "value": "0.0"
  #       },
  #       "required": false
  #     },
  #     {
  #       "type": "field",
  #       "name": "deltaMode",
  #       "extAttrs": [],
  #       "idlType": {
  #         "type": "dictionary-type",
  #         "extAttrs": [],
  #         "generic": "",
  #         "nullable": false,
  #         "union": false,
  #         "idlType": "unsigned long"
  #       },
  #       "default": {
  #         "type": "number",
  #         "value": "0"
  #       },
  #       "required": false
  #     }
  #   ],
  #   "extAttrs": [],
  #   "partial": false
  # }

  class InputEvent < UIEvent
    include Prism::BindingHelpers

    # def initialize(type, eventInitDict = UNDEFINED)
    # end

    bind_attr_reader :data, return_type: 'DOMString'
    bind_attr_reader :isComposing, return_type: 'boolean'
    bind_attr_reader :inputType, return_type: 'DOMString'
  end

  # Skipped definition, name=InputEventInit, type='dictionary':
  # {
  #   "type": "dictionary",
  #   "name": "InputEventInit",
  #   "inheritance": "UIEventInit",
  #   "members": [
  #     {
  #       "type": "field",
  #       "name": "data",
  #       "extAttrs": [],
  #       "idlType": {
  #         "type": "dictionary-type",
  #         "extAttrs": [],
  #         "generic": "",
  #         "nullable": true,
  #         "union": false,
  #         "idlType": "DOMString"
  #       },
  #       "default": {
  #         "type": "null"
  #       },
  #       "required": false
  #     },
  #     {
  #       "type": "field",
  #       "name": "isComposing",
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
  #       "name": "inputType",
  #       "extAttrs": [],
  #       "idlType": {
  #         "type": "dictionary-type",
  #         "extAttrs": [],
  #         "generic": "",
  #         "nullable": false,
  #         "union": false,
  #         "idlType": "DOMString"
  #       },
  #       "default": {
  #         "type": "string",
  #         "value": ""
  #       },
  #       "required": false
  #     }
  #   ],
  #   "extAttrs": [],
  #   "partial": false
  # }

  class KeyboardEvent < UIEvent
    include Prism::BindingHelpers

    # def initialize(type, eventInitDict = UNDEFINED)
    # end

    DOM_KEY_LOCATION_STANDARD = 0x00
    DOM_KEY_LOCATION_LEFT = 0x01
    DOM_KEY_LOCATION_RIGHT = 0x02
    DOM_KEY_LOCATION_NUMPAD = 0x03

    bind_attr_reader :key, return_type: 'DOMString'
    bind_attr_reader :code, return_type: 'DOMString'
    bind_attr_reader :location, return_type: 'unsigned long'
    bind_attr_reader :ctrlKey, return_type: 'boolean'
    bind_attr_reader :shiftKey, return_type: 'boolean'
    bind_attr_reader :altKey, return_type: 'boolean'
    bind_attr_reader :metaKey, return_type: 'boolean'
    bind_attr_reader :repeat, return_type: 'boolean'
    bind_attr_reader :isComposing, return_type: 'boolean'

    bind_operation :getModifierState, return_type: 'boolean', args: [
      {"name":"keyArg","type":"DOMString","optional":false}
    ]
  end

  # Skipped definition, name=KeyboardEventInit, type='dictionary':
  # {
  #   "type": "dictionary",
  #   "name": "KeyboardEventInit",
  #   "inheritance": "EventModifierInit",
  #   "members": [
  #     {
  #       "type": "field",
  #       "name": "key",
  #       "extAttrs": [],
  #       "idlType": {
  #         "type": "dictionary-type",
  #         "extAttrs": [],
  #         "generic": "",
  #         "nullable": false,
  #         "union": false,
  #         "idlType": "DOMString"
  #       },
  #       "default": {
  #         "type": "string",
  #         "value": ""
  #       },
  #       "required": false
  #     },
  #     {
  #       "type": "field",
  #       "name": "code",
  #       "extAttrs": [],
  #       "idlType": {
  #         "type": "dictionary-type",
  #         "extAttrs": [],
  #         "generic": "",
  #         "nullable": false,
  #         "union": false,
  #         "idlType": "DOMString"
  #       },
  #       "default": {
  #         "type": "string",
  #         "value": ""
  #       },
  #       "required": false
  #     },
  #     {
  #       "type": "field",
  #       "name": "location",
  #       "extAttrs": [],
  #       "idlType": {
  #         "type": "dictionary-type",
  #         "extAttrs": [],
  #         "generic": "",
  #         "nullable": false,
  #         "union": false,
  #         "idlType": "unsigned long"
  #       },
  #       "default": {
  #         "type": "number",
  #         "value": "0"
  #       },
  #       "required": false
  #     },
  #     {
  #       "type": "field",
  #       "name": "repeat",
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
  #       "name": "isComposing",
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

  class CompositionEvent < UIEvent
    include Prism::BindingHelpers

    # def initialize(type, eventInitDict = UNDEFINED)
    # end

    bind_attr_reader :data, return_type: 'DOMString'
  end

  # Skipped definition, name=CompositionEventInit, type='dictionary':
  # {
  #   "type": "dictionary",
  #   "name": "CompositionEventInit",
  #   "inheritance": "UIEventInit",
  #   "members": [
  #     {
  #       "type": "field",
  #       "name": "data",
  #       "extAttrs": [],
  #       "idlType": {
  #         "type": "dictionary-type",
  #         "extAttrs": [],
  #         "generic": "",
  #         "nullable": false,
  #         "union": false,
  #         "idlType": "DOMString"
  #       },
  #       "default": {
  #         "type": "string",
  #         "value": ""
  #       },
  #       "required": false
  #     }
  #   ],
  #   "extAttrs": [],
  #   "partial": false
  # }

  class UIEvent
    include Prism::BindingHelpers

    bind_operation :initUIEvent, return_type: 'undefined', args: [
      {"name":"typeArg","type":"DOMString","optional":false},
      {"name":"bubblesArg","type":"boolean","optional":true},
      {"name":"cancelableArg","type":"boolean","optional":true},
      {"name":"viewArg","type":"Window","optional":true},
      {"name":"detailArg","type":"long","optional":true}
    ]
  end

  class MouseEvent
    include Prism::BindingHelpers

    bind_operation :initMouseEvent, return_type: 'undefined', args: [
      {"name":"typeArg","type":"DOMString","optional":false},
      {"name":"bubblesArg","type":"boolean","optional":true},
      {"name":"cancelableArg","type":"boolean","optional":true},
      {"name":"viewArg","type":"Window","optional":true},
      {"name":"detailArg","type":"long","optional":true},
      {"name":"screenXArg","type":"long","optional":true},
      {"name":"screenYArg","type":"long","optional":true},
      {"name":"clientXArg","type":"long","optional":true},
      {"name":"clientYArg","type":"long","optional":true},
      {"name":"ctrlKeyArg","type":"boolean","optional":true},
      {"name":"altKeyArg","type":"boolean","optional":true},
      {"name":"shiftKeyArg","type":"boolean","optional":true},
      {"name":"metaKeyArg","type":"boolean","optional":true},
      {"name":"buttonArg","type":"short","optional":true},
      {"name":"relatedTargetArg","type":"EventTarget","optional":true}
    ]
  end

  class KeyboardEvent
    include Prism::BindingHelpers

    bind_operation :initKeyboardEvent, return_type: 'undefined', args: [
      {"name":"typeArg","type":"DOMString","optional":false},
      {"name":"bubblesArg","type":"boolean","optional":true},
      {"name":"cancelableArg","type":"boolean","optional":true},
      {"name":"viewArg","type":"Window","optional":true},
      {"name":"keyArg","type":"DOMString","optional":true},
      {"name":"locationArg","type":"unsigned long","optional":true},
      {"name":"ctrlKey","type":"boolean","optional":true},
      {"name":"altKey","type":"boolean","optional":true},
      {"name":"shiftKey","type":"boolean","optional":true},
      {"name":"metaKey","type":"boolean","optional":true}
    ]
  end

  class CompositionEvent
    include Prism::BindingHelpers

    bind_operation :initCompositionEvent, return_type: 'undefined', args: [
      {"name":"typeArg","type":"DOMString","optional":false},
      {"name":"bubblesArg","type":"boolean","optional":true},
      {"name":"cancelableArg","type":"boolean","optional":true},
      {"name":"viewArg","type":"WindowProxy","optional":true},
      {"name":"dataArg","type":"DOMString","optional":true}
    ]
  end

  class UIEvent
    include Prism::BindingHelpers

    bind_attr_reader :which, return_type: 'unsigned long'
  end

  # Skipped definition, name=UIEventInit, type='dictionary':
  # {
  #   "type": "dictionary",
  #   "name": "UIEventInit",
  #   "inheritance": null,
  #   "members": [
  #     {
  #       "type": "field",
  #       "name": "which",
  #       "extAttrs": [],
  #       "idlType": {
  #         "type": "dictionary-type",
  #         "extAttrs": [],
  #         "generic": "",
  #         "nullable": false,
  #         "union": false,
  #         "idlType": "unsigned long"
  #       },
  #       "default": {
  #         "type": "number",
  #         "value": "0"
  #       },
  #       "required": false
  #     }
  #   ],
  #   "extAttrs": [],
  #   "partial": true
  # }

  class KeyboardEvent
    include Prism::BindingHelpers

    bind_attr_reader :charCode, return_type: 'unsigned long'
    bind_attr_reader :keyCode, return_type: 'unsigned long'
  end

  # Skipped definition, name=KeyboardEventInit, type='dictionary':
  # {
  #   "type": "dictionary",
  #   "name": "KeyboardEventInit",
  #   "inheritance": null,
  #   "members": [
  #     {
  #       "type": "field",
  #       "name": "charCode",
  #       "extAttrs": [],
  #       "idlType": {
  #         "type": "dictionary-type",
  #         "extAttrs": [],
  #         "generic": "",
  #         "nullable": false,
  #         "union": false,
  #         "idlType": "unsigned long"
  #       },
  #       "default": {
  #         "type": "number",
  #         "value": "0"
  #       },
  #       "required": false
  #     },
  #     {
  #       "type": "field",
  #       "name": "keyCode",
  #       "extAttrs": [],
  #       "idlType": {
  #         "type": "dictionary-type",
  #         "extAttrs": [],
  #         "generic": "",
  #         "nullable": false,
  #         "union": false,
  #         "idlType": "unsigned long"
  #       },
  #       "default": {
  #         "type": "number",
  #         "value": "0"
  #       },
  #       "required": false
  #     }
  #   ],
  #   "extAttrs": [],
  #   "partial": true
  # }

  class MutationEvent < Event
    include Prism::BindingHelpers

    MODIFICATION = 1
    ADDITION = 2
    REMOVAL = 3

    bind_attr_reader :relatedNode, return_type: 'Node'
    bind_attr_reader :prevValue, return_type: 'DOMString'
    bind_attr_reader :newValue, return_type: 'DOMString'
    bind_attr_reader :attrName, return_type: 'DOMString'
    bind_attr_reader :attrChange, return_type: 'unsigned short'

    bind_operation :initMutationEvent, return_type: 'undefined', args: [
      {"name":"typeArg","type":"DOMString","optional":false},
      {"name":"bubblesArg","type":"boolean","optional":true},
      {"name":"cancelableArg","type":"boolean","optional":true},
      {"name":"relatedNodeArg","type":"Node","optional":true},
      {"name":"prevValueArg","type":"DOMString","optional":true},
      {"name":"newValueArg","type":"DOMString","optional":true},
      {"name":"attrNameArg","type":"DOMString","optional":true},
      {"name":"attrChangeArg","type":"unsigned short","optional":true}
    ]
  end

  Document.include(NonElementParentNode)

  DocumentFragment.include(NonElementParentNode)

  Document.include(DocumentOrShadowRoot)

  ShadowRoot.include(DocumentOrShadowRoot)

  Document.include(ParentNode)

  DocumentFragment.include(ParentNode)

  Element.include(ParentNode)

  Element.include(NonDocumentTypeChildNode)

  CharacterData.include(NonDocumentTypeChildNode)

  DocumentType.include(ChildNode)
end