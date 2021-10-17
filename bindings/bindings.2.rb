module JS
  Element.include(ChildNode)

  CharacterData.include(ChildNode)

  Element.include(Slottable)

  Text.include(Slottable)

  Document.include(XPathEvaluatorBase)

  XPathEvaluator.include(XPathEvaluatorBase)

  Document.include(GlobalEventHandlers)

  Document.include(DocumentAndElementEventHandlers)

  HTMLElement.include(GlobalEventHandlers)

  HTMLElement.include(DocumentAndElementEventHandlers)

  HTMLElement.include(ElementContentEditable)

  HTMLElement.include(HTMLOrSVGElement)

  # HTMLLinkElement.include(LinkStyle)

  # HTMLStyleElement.include(LinkStyle)

  HTMLBodyElement.include(WindowEventHandlers)

  HTMLAnchorElement.include(HTMLHyperlinkElementUtils)

  HTMLAreaElement.include(HTMLHyperlinkElementUtils)

  CanvasRenderingContext2D.include(CanvasState)

  CanvasRenderingContext2D.include(CanvasTransform)

  CanvasRenderingContext2D.include(CanvasCompositing)

  CanvasRenderingContext2D.include(CanvasImageSmoothing)

  CanvasRenderingContext2D.include(CanvasFillStrokeStyles)

  CanvasRenderingContext2D.include(CanvasShadowStyles)

  CanvasRenderingContext2D.include(CanvasFilters)

  CanvasRenderingContext2D.include(CanvasRect)

  CanvasRenderingContext2D.include(CanvasDrawPath)

  CanvasRenderingContext2D.include(CanvasUserInterface)

  CanvasRenderingContext2D.include(CanvasText)

  CanvasRenderingContext2D.include(CanvasDrawImage)

  CanvasRenderingContext2D.include(CanvasImageData)

  CanvasRenderingContext2D.include(CanvasPathDrawingStyles)

  CanvasRenderingContext2D.include(CanvasTextDrawingStyles)

  CanvasRenderingContext2D.include(CanvasPath)

  Path2D.include(CanvasPath)

  OffscreenCanvasRenderingContext2D.include(CanvasState)

  OffscreenCanvasRenderingContext2D.include(CanvasTransform)

  OffscreenCanvasRenderingContext2D.include(CanvasCompositing)

  OffscreenCanvasRenderingContext2D.include(CanvasImageSmoothing)

  OffscreenCanvasRenderingContext2D.include(CanvasFillStrokeStyles)

  OffscreenCanvasRenderingContext2D.include(CanvasShadowStyles)

  OffscreenCanvasRenderingContext2D.include(CanvasFilters)

  OffscreenCanvasRenderingContext2D.include(CanvasRect)

  OffscreenCanvasRenderingContext2D.include(CanvasDrawPath)

  OffscreenCanvasRenderingContext2D.include(CanvasText)

  OffscreenCanvasRenderingContext2D.include(CanvasDrawImage)

  OffscreenCanvasRenderingContext2D.include(CanvasImageData)

  OffscreenCanvasRenderingContext2D.include(CanvasPathDrawingStyles)

  OffscreenCanvasRenderingContext2D.include(CanvasTextDrawingStyles)

  OffscreenCanvasRenderingContext2D.include(CanvasPath)

  # ElementInternals.include(ARIAMixin)

  Window.include(GlobalEventHandlers)

  Window.include(WindowEventHandlers)

  Window.include(WindowOrWorkerGlobalScope)

  WorkerGlobalScope.include(WindowOrWorkerGlobalScope)

  Navigator.include(NavigatorID)

  Navigator.include(NavigatorLanguage)

  Navigator.include(NavigatorOnLine)

  Navigator.include(NavigatorContentUtils)

  Navigator.include(NavigatorCookies)

  Navigator.include(NavigatorPlugins)

  Navigator.include(NavigatorConcurrentHardware)

  Window.include(AnimationFrameProvider)

  DedicatedWorkerGlobalScope.include(AnimationFrameProvider)

  Worker.include(AbstractWorker)

  SharedWorker.include(AbstractWorker)

  WorkerNavigator.include(NavigatorID)

  WorkerNavigator.include(NavigatorLanguage)

  WorkerNavigator.include(NavigatorOnLine)

  WorkerNavigator.include(NavigatorConcurrentHardware)

  Window.include(WindowSessionStorage)

  Window.include(WindowLocalStorage)

  HTMLFrameSetElement.include(WindowEventHandlers)

  Request.include(Body)

  Response.include(Body)
end