#include "asm-dom.hpp"

using namespace asmdom;

int main() {
  Config config = Config();
  init(config);

  // without gccx
  VNode* vnode = h("div",
    Data(
      Callbacks {
        {"onclick", [](emscripten::val e) -> bool {
          emscripten::val::global("console").call<void>("log", emscripten::val("another click"));
          return true;
        }}
      }
    ),
    Children {
      h("span",
        Data(
          Attrs {
            {"style", "font-weight: normal; font-style: italic"}
          }
        ),
        std::string("This is now italic type")
      ),
      h(" and this is just normal text", true),
      h("a",
        Data(
          Attrs {
            {"href", "/bar"}
          }
        ),
        std::string("I'll take you places!")
      )
    }
  );
  // Patch into empty DOM element – this modifies the DOM as a side effect
  patch(
    emscripten::val::global("document").call<emscripten::val>(
      "getElementById",
      std::string("root")
    ),
    vnode
  );

  return 0;
};
