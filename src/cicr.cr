require "./cicr/**"
require "multicore"

module CICR
  VERSION = "0.1.0-dev"

  def self.start
    CLI::Parser.run
    config = CLI::Config.instance
    mc = config.multicore
    Multicore.startup(mc) { run }
  end

  def self.run
    process_id = ENV["MULTICORE_ID"]?
    puts "Starting process: #{process_id}" if process_id
    Router.start
  end
end

CICR.start
