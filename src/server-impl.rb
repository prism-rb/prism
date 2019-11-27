begin
require_relative "./require-bundler"

request = Rack::Request.new env

def render_file_link(p, name)
  <<~HTML
    <li><a href="#{File.join(p, name)}">#{name}</a></li>
  HTML
end

def directory_view(request, p, files)
  <<~HTML
  <!DOCTYPE html>
  <html lang=en-us>

  <head>
    <meta charset=utf-8>
    <meta content="text/html; charset=utf-8" http-equiv=Content-Type>
    <title>Prism Server</title>
    <style>
      html, body {
        font-family: sans-serif;
      }
    </style>
  </head>

    <body>
      <h1>Prism Dev Server</h1>
      <h2>#{File.join(Dir.pwd, p)}</h2>

      <ul>
        #{files.map { |f| render_file_link(request.path, f) }.join("\n")}
      </ul>

    </body>
  </html>
  HTML
end

def app_view(p)
  <<~HTML
    <!DOCTYPE html>
    <html lang=en-us>

    <head>
      <meta charset=utf-8>
      <meta content="text/html; charset=utf-8" http-equiv=Content-Type>
    </head>
      <body>
        <div id="root"></div>
      </body>
      <script type="text/javascript" src="/prism-assets/prism.js"></script>
      <script type="text/javascript" async src="/prism-assets/bundle.js"></script>
      <script type="text/javascript">
        Prism.run("#root", "#{File.basename(p)}");
      </script>
    </html>
  HTML
end

p = File.join('.', request.path);

if p.start_with?('./prism-assets')
  p = File.join(prism_path, 'build', File.basename(p));

  return serve_file(p)
end

if p.start_with?('./prism-ruby')
  p = File.join(prism_path, 'src', File.basename(p));

  return serve_file(p)
end

if File.directory?(p)
  files = Dir.entries(p)

  return [200, {"Content-Type" => "text/html"}, [directory_view(request, p, files)]]
end


def serve_file(p)
  return [404, {}, []] unless File.exists?(p)

  if p.end_with?(".rb")
    bundle = Bundle.from_main(p).analyze_file("src/prism.rb")
    return [200, {"Content-Type" => "text/json"}, [bundle.to_json]]
  end

  content_type = ""
  content_type = "application/wasm" if p.end_with?(".wasm")
  content_type = "text/javascript" if p.end_with?(".js")
  content_type = "text/json" if p.end_with?(".json")
  content_type = "text/html" if p.end_with?(".html")

  [200, {"Content-Type" => content_type}, [File.read(p)]]
end

if (p.end_with?("rb") && (request.get_header("HTTP_ACCEPT") || "").include?("text/html"))
  return [200, {"Content-Type" => "text/html"}, app_view(p)]
end

serve_file(p)
rescue Exception => e
  raise e
end
