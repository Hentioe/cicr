module CICR
  macro def_exception(name)
    class {{name}} < Exception
    end
  end

  def_exception NotFoundException
end
