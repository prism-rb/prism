Gem::Specification.new do |s|
  s.name        = 'prism-cli'
  s.version     = '0.0.5'
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
  s.files += Dir.glob("dist/*")
  s.files += Dir.glob("mruby/include/**/*");
  s.homepage    = 'https://rubygems.org/gems/prism-cli'
  s.license     = 'MIT'
end
