require "./cicr/*"

CICR::CLI::Parser.run

module CICR
  VERSION = "0.1.0-dev"

  def self.start
    Router.run
  end
end

CICR.start
