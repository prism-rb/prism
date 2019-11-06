Gem::Specification.new do |s|
  s.name        = 'prism-cli'
  s.version     = '0.0.7'
  s.date        = '2019-10-29'
  s.summary     = "Build frontend web apps with Ruby and Wasm"
  s.description = File.read("./README.md")
  s.authors     = ["Nick Johnstone"]
  s.email       = 'ncwjohnstone@gmail.com'
  s.executables << 'prism'
  s.files       = [
    "wasm-server.js",
    "main.c",
    "mruby/build/emscripten/lib/libmruby.a"
  ]

  s.files += Dir.glob("src/*.rb")
  s.files += Dir.glob("build/*")
  s.files += Dir.glob("mruby/include/**/*");
  s.homepage    = 'https://github.com/prism/prism-rb'
  s.license     = 'MIT'
end
