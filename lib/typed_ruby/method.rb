# class MyRubyClass
#   include TypedRuby::TypeChecker
#   
#   typed_method(:my_method, argument_name0: :any, :argument_name1: :string, { argument_name: [with_default_value, :string] }, return: :boolean) do
#     puts argument_name0
#     puts argument_name1
#     puts argument_name2
#
#     return true
#   end
#
# end
#
#
#
#
class TypedRuby::Method
  def initialize  
  end
end
