module TypedRuby
  class MissingTypeDefinition < StandardError; end
  class InvalidArgumentLength < StandardError; end
  class WrongArgumentType < StandardError; end
  class WrongReturnType < StandardError; end

  class ExceptionHandler

    def self.missing_type_definition argument_index
      raise MissingTypeDefinition.new(
        "Type not defined for argument #{argument_index+1}"
      )
    end

    def self.wrong_argument_type expected, received
      raise WrongArgumentType.new(
        "expected type #{expected}, received #{received}."
      )
    end

    def self.wrong_return_type expected, received
      raise WrongReturnType.new(
        "expected type #{expected}, received #{received}."
      )
    end

    def self.invalid_argument_length expected, received
      raise InvalidArgumentLength.new(
        "expected #{expected} arguments, received #{received}."
      )
    end
  end
end
