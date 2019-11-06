Gem::Specification.new do |s|
  s.name        = 'prism-cli'
  s.version     = '0.0.8'
  s.date        = '2019-10-29'
  s.summary     = "Build frontend web apps with Ruby and Wasm"
  s.description = File.read("./README.md")
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
