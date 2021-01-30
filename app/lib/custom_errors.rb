module CustomErrors

  class FileNotFoundException < Exception
    def initialize(message)
      super(message)
    end
  end

  class InvaldCnabFileException < Exception
    def initialize(message)
      super(message)
    end
  end
  
end