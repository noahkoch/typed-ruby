module TypedRuby
  class MissingTypeDefinition < StandardError; end
  class InvalidArgumentLength < StandardError; end
  class WrongArgumentType < StandardError; end
  class WrongReturnType < StandardError; end

  class ExceptionHandler

    def self.missing_type_definition method_identifier, argument_index
      raise MissingTypeDefinition.new(
        "#{method_identifier}: type not defined for argument #{argument_index+1}"
      )
    end

    def self.wrong_argument_type method_identifier, expected, received
      raise WrongArgumentType.new(
        "#{method_identifier}: expected type #{expected}, received #{received}."
      )
    end

    def self.wrong_return_type method_identifier, expected, received
      raise WrongReturnType.new(
        "#{method_identifier}: expected type #{expected}, received #{received}."
      )
    end

    def self.invalid_argument_length method_identifier, expected, received
      raise InvalidArgumentLength.new(
        "#{method_identifier}: expected #{expected} arguments, received #{received}."
      )
    end

  end
end
