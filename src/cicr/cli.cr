require "admiral"

module CICR::CLI
  class Config
    UNDEFINED = "undefined"

    @@instance = Config.new

    getter port = 65536
    getter public = UNDEFINED
    getter prod = false
    getter gzip = false
    getter bind = UNDEFINED
    getter portal = UNDEFINED
    getter multicore = -1
    getter originals = UNDEFINED
    getter outputs = UNDEFINED

    @log_level = UNDEFINED

    def initialize
    end

    private def initialize(@port, @public, @prod, @gzip, @bind, @multicore, @originals, @outputs)
    end

    def self.init(flags)
      @@instance = self.new(
        flags.port,
        flags.public,
        flags.prod,
        flags.gzip,
        flags.bind,
        flags.multicore,
        flags.originals,
        flags.outputs
      )
    end

    def self.instance
      @@instance
    end
  end

  class Parser < Admiral::Command
    define_help description: "Free, secure desktop notification service"

    define_flag port : Int32,
      description: "Listening port number",
      default: 8080,
      long: port,
      short: p,
      required: true

    define_flag public : String,
      description: "Public static file path",
      default: "public",
      long: public,
      required: true

    define_flag bind : String,
      description: "Bind host address",
      default: "0.0.0.0",
      long: bind,
      required: true

    define_flag prod : Bool,
      description: "Running in production mode",
      default: false,
      long: prod,
      required: true

    define_flag gzip : Bool,
      description: "Enable gzip compression response",
      default: false,
      long: gzip,
      required: true

    define_flag multicore : Int32,
      description: "Specify multiple processes, -1 means disable, 0 means automatic, then...",
      default: -1,
      long: multicore,
      short: c,
      required: true

    define_flag originals : String,
      description: "Original image directory path",
      long: originals,
      short: o,
      required: true

    define_flag outputs : String,
      description: "Output image directory path",
      long: outputs,
      short: O,
      required: true

    def run
      Config.init(flags)
    end
  end
end
