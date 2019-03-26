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
      run
    end
  end

  def run
    process_id = ENV["MULTICORE_ID"]?
    puts "Starting process: #{process_id}" if process_id
    Router.start
  end
end

CICR.start
