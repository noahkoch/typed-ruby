require 'typed_ruby/exceptions'
require 'typed_ruby/boolean'

class TypedRuby::TypedClass

  def self.deft method_name, *types, return_type:
    define_method(method_name) do |*arguments|
      if arguments.count < types.count
        TypedRuby::ExceptionHandler.invalid_argument_length(
          types.count,
          arguments.count
        )
      end

      arguments.each_with_index do |arg, index| 
        if types[index].nil?
          TypedRuby::ExceptionHandler.missing_type_definition(index)
        end

        next if types[index].to_s == 'any'

        if !arg.is_a?(types[index])
          TypedRuby::ExceptionHandler.wrong_argument_type(
            types[index],
            arg.class
          )
        end
      end

      return_value = yield(*arguments)

      if !return_value.is_a?(return_type)
        TypedRuby::ExceptionHandler.wrong_return_type(
          return_type,
          return_value.class
        )
      end

      return return_value
    end
  end

end
