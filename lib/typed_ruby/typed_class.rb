class TypedRuby::TypedClass

  def self.deft method_name, *types, return:
    define_method(method_name) do |*arguments|
      arguments.each_with_index do |arg, index| 
        if !arg.is_a?(types[index].to_s.capitalize.constantize)
          raise "Bad type"
        end
      end

      yield(*arguments)
    end
  end

end
