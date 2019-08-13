require 'typed_ruby/exceptions'
require 'typed_ruby/boolean'

class TypedRuby::Validator
  def self.validate_argument_types method_identifier, arguments, expected_types
    arguments.each_with_index do |arg, index| 
      if expected_types[index].nil?
        TypedRuby::ExceptionHandler.missing_type_definition(
          method_identifier,
          index
        )
      end

      next if expected_types[index].to_s == 'any'

      if !arg.is_a?(expected_types[index])
        TypedRuby::ExceptionHandler.wrong_argument_type(
          method_identifier,
          expected_types[index],
          arg.class
        )
      end
    end
  end

  def self.validate_argument_length method_identifier, arguments, expected_types 
    if arguments.count < expected_types.count
      TypedRuby::ExceptionHandler.invalid_argument_length(
        method_identifier,
        expected_types.count,
        arguments.count
      )
    end
  end

  def self.validate_return_value method_identifier, expected_return_type,  &block
    return_value = block.call

    if !return_value.is_a?(expected_return_type)
      TypedRuby::ExceptionHandler.wrong_return_type(
        method_identifier,
        expected_return_type,
        return_value.class
      )
    end

    return return_value
  end
end
