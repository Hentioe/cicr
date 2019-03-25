require "./cicr/**"
require "multicore"

module CICR
  VERSION = "0.1.0-dev"

  extend self

  def start
    CLI::Parser.run
    config = CLI::Config.instance
    mc = config.multicore
    Multicore.startup(mc) do
      start(config)
    end
  end

  def start(config)
    process_id = ENV["MULTICORE_ID"]?
    puts "Starting process: #{process_id}" if process_id
    Router.start(
      port: config.port,
      public: config.public,
      prod: config.prod,
      gzip: config.gzip,
      bind: config.bind,
      originals: "originals",
      outputs: "outputs"
    )
  end
end

CICR.start
