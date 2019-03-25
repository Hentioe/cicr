require "img_kit"

module CICR::Display
  extend self

  def init_routes(originals, outputs)
    get "/display/:fpath" do |env|
      fpath = env.params.url["fpath"]
      processes_expr = env.params.query["processes"]
      processor_pipe = processes(processes_expr)
      img = ImgKit::Image.new("#{originals}/#{fpath}")
      processor_pipe.each do |processor, args|
        case processor
        when :resize
          if args.is_a?(NamedTuple(width: Int32, height: Int32))
            img.resize(**args)
          end
        when :blur
          if args.is_a?(NamedTuple(sigma: Float64))
            img.blur(**args)
          end
        when :crop
          if args.is_a?(NamedTuple(width: Int32, height: Int32, x: Int32, y: Int32))
            img.crop(**args)
          end
        else
        end
      end
      output = "#{outputs}/demo.jpg"
      img.save(output)
      # sign = sign(fpath)
      send_file env, output
    end
  end

  def sign(fpath, params)
  end

  RESIZE_PROCESS_MATCH = /resize\..+/
  BLUR_PROCESS_MATCH   = /blur\..+/
  CROP_PROCESS_MATCH   = /crop\..+/

  def processes(expr)
    # resize.w_100,h_100|blur.s_10|crop.x_1
    # type ProcessArgsType = Tuple(Symbol, Int32, Int32) |
    #                Tuple(Symbol, Float64) |
    #                Tuple(Symbol, Int32, Int32, Int32, Int32)
    pipe = Array(Tuple(Symbol, NamedTuple(width: Int32, height: Int32)) |
                 Tuple(Symbol, NamedTuple(sigma: Float64)) |
                 Tuple(Symbol, NamedTuple(width: Int32, height: Int32, x: Int32, y: Int32))).new
    expr.split "|", remove_empty: true do |process|
      if process =~ RESIZE_PROCESS_MATCH
        width, height = parse_resize_process(process)
        pipe << {:resize, {width: width, height: height}}
      elsif process =~ BLUR_PROCESS_MATCH
        sigma = parse_blur_process(process)
        pipe << {:blur, {sigma: sigma}}
      elsif process =~ CROP_PROCESS_MATCH
        width, height, x, y = parse_crop_process(process)
        pipe << {:crop, {width: width, height: height, x: x, y: y}}
      end
    end
    pipe
  end

  def parse_resize_process(expr)
    vexpr = expr.split(".")[1]
    width = parse_int_value("w", vexpr)
    height = parse_int_value("h", vexpr)
    {width, height}
  end

  def parse_blur_process(expr)
    vexpr = expr.split(".")[1]
    sigma = parse_float_value("s", vexpr)
    sigma
  end

  def parse_crop_process(expr)
    vexpr = expr.split(".")[1]
    width = parse_int_value("w", vexpr)
    height = parse_int_value("h", vexpr)
    x = parse_int_value("x", vexpr)
    y = parse_int_value("y", vexpr)
    {width, height, x, y}
  end

  def parse_int_value(key, expr, default = 0)
    parse_value(key, expr, default).to_i
  end

  def parse_float_value(key, expr, default = 0.0)
    parse_value(key, expr, default).to_f
  end

  def parse_value(key, expr, default = Nil)
    prefix = "#{key}_"
    expr.split ",", remove_empty: true do |value_s|
      if value_s.starts_with? prefix
        return value_s.gsub(prefix, "")
      end
    end
    default
  end
end
