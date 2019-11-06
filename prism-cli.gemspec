Gem::Specification.new do |s|
  s.name        = 'prism-cli'
  s.version     = '0.0.9'
  s.date        = '2019-10-29'
  s.summary     = "Build frontend web apps with Ruby and Wasm"
  s.description = <<-HEREDOC.strip
Prism is a framework for building clientside web apps with Ruby.

It's powered by mruby, emscripten and WebAssembly.

For more information check out the docs on the github repo.
  HEREDOC
  s.authors     = ["Nick Johnstone"]
  s.email       = 'ncwjohnstone@gmail.com'
  s.executables << 'prism'
  s.files       = [
    "wasm-server.js"
  ]

  s.files += Dir.glob("src/*.rb")
  s.files += Dir.glob("build/*")
  s.homepage    = 'https://github.com/prism/prism-rb'
  s.license     = 'MIT'
end
