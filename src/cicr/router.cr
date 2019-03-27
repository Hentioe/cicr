require "kemal"
require "json"

module CICR::Router
  extend self

  def start
    config = CLI::Config.instance
    serve_static({"gzip" => config.gzip})
    public_folder config.public

    init_routes

    Kemal.config.env = "production" if config.prod
    Kemal.run(args: nil) do |kermal_cfg|
      server = kermal_cfg.server.not_nil!
      server.bind_tcp config.bind, config.port, reuse_port: true
    end
  end

  def init_routes
    get "/" do
      render "src/views/index.ecr"
    end

    Display.init_routes

    error 500 do |env, ex|
      data = Hash(String, String?).new
      message = "internal error"
      status_code = 400
      if ex.is_a?(NotFoundException)
        status_code = 404
        message = "resource '#{ex.message}' does not exist"
      else
        message = ex.message
      end
      data["message"] = message
      env.response.status_code = status_code
      env.response.content_type = "application/json; charset=utf-8"
      data.to_json
    end
  end
end
