require 'typed_ruby/argument_validator'

class TypedRuby::TypedClass

  def self.deft method_name, *expected_types, return_type:, private_method: false, &block
    define_method(method_name) do |*arguments|
      method_identifier = "#{self.class.to_s}##{method_name}"

      TypedRuby::Validator.validate_argument_length(
        method_identifier,
        arguments,
        expected_types
      )

      TypedRuby::Validator.validate_argument_types(
        method_identifier,
        arguments,
        expected_types
      )

      return TypedRuby::Validator.validate_return_value(
        method_identifier,
        return_type,
      ) do
        instance_exec(*arguments, &block)
      end

    end

    if private_method
      send(:private, method_name)
    end
  end

  def self.self_deft method_name, *expected_types, return_type:, private_method: false, &block
    define_singleton_method(method_name) do |*arguments|

      method_identifier = "#{self.class.to_s}::#{method_name}"

      if private_method
        self.class.send(:private, method_name)
      end

      TypedRuby::Validator.validate_argument_length(
        method_identifier,
        arguments,
        expected_types
      )

      TypedRuby::Validator.validate_argument_types(
        method_identifier,
        arguments,
        expected_types
      )

      return TypedRuby::Validator.validate_return_value(
        method_identifier,
        return_type
      ) do
        block.call(*arguments)
      end

    end
  end
end
