# frozen_string_literal: true

module ExceptionHandlers
  class Error < GraphQL::ExecutionError
    attr :message, :extensions

    def initialize(opts={})
      code    = opts[:code]   || 2000
      status  = opts[:status] || 400

      @message = opts[:text]
      @extensions = { code: code, status: status  }
    end
  end

  class AuthorizationError < Error
    def initialize
      super text: 'unauthenticated', status: 401, code: 2001
    end
  end

  class ParamsError < Error
    def initialize(msg)
      super code: 2002, text: msg, status: 400
    end
  end

  class RecordExistError < Error
    def initialize(msg)
      super code: 2003, text: msg, status: 409
    end
  end

  class TokenError < Error
    def initialize(msg)
      super code: 2004, text: msg, status: 504
    end
  end
end
