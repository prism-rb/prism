require 'json'
require 'pathname'

# We are indeed parsing Ruby with regex. Probably not a great idea
require_regex = /
  require                 # definitely starts with require
  (_relative)?            # possible followed by _relative, which we want to capture
  \s*                     # there might be some space after a require
  \(?                     # we might have an open paren
  \s*                     # possible followed by some more space
  ['|"]                   # either ' or " (sorry if you're using another quote type)
  (                       # begin capturing the string argument
  [^'|"]+                 # capture until we hit an end quote
  )                       # end the capture
/x

REQUIRE_REGEX = Regexp.compile(require_regex.source, require_regex.options)

def analyze_requires(bundle, path)
  return if bundle.has_file?(path)

  code = File.read(path)
  bundle.add_file(Pathname.new(path).cleanpath, code)

  matches = code.scan(REQUIRE_REGEX)

  matches.each do |(relative, match_path)|
    relative = false
    #fail "Only relative imports are currently supported" unless relative
    if relative
      match_path = File.join(File.dirname(path), match_path)
    end
    match_path += ".rb" unless match_path.end_with?(".rb")
    analyze_requires(bundle, match_path)
  end
end

class Bundle
  attr_reader :main

  def self.from_main(main)
    if (main.start_with?("./"))
      main = main[2..]
    end
    bundle = Bundle.new(main)
    analyze_requires(bundle, bundle.main)
    bundle
  end

  def analyze_file(path)
    analyze_requires(self, path)
    self
  end

  def initialize(main)
    @main = main
    @files = {}
  end

  def has_file?(path)
    @files.include?(path)
  end

  def add_file(path, code)
    @files[path] = code
  end

  def to_json
    JSON.generate({
      files: @files,
      main: @main
    })
  end
end

