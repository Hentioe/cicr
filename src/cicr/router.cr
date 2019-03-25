require "kemal"

module CICR::Router
  extend self

  def start(port, public, prod, gzip, bind, originals, outputs)
    serve_static({"gzip" => gzip})
    public_folder public

    init_routes(originals, outputs)

    Kemal.config.env = "production" if prod
    Kemal.run(args: nil) do |config|
      server = config.server.not_nil!
      server.bind_tcp bind, port, reuse_port: true
    end
  end

  def init_routes(originals, outputs)
    get "/" do
      render "src/views/index.ecr"
    end

    Display.init_routes(originals, outputs)
  end
end
