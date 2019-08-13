require 'typed_ruby/typed_class'
require 'typed_ruby/exceptions'

class MyGoodClass < TypedRuby::TypedClass

  deft :hello_world, String, Integer, return_type: NilClass do |name, age|
    puts "Hello, I am #{name} and I am #{age} years old!"
  end

end

class MyBadClass < TypedRuby::TypedClass

  deft :hello_world, String, Integer, return_type: Boolean do |name, age|
    puts "Hello, I am #{name} and I am #{age} years old!"
  end

end

RSpec.describe 'TypedClass' do

  context "proper method structures" do
    let (:test_class) { MyGoodClass.new }

    it 'can call a method' do
      expect {
        test_class.hello_world('Noah', 24)
      }.not_to raise_error
    end

    it 'checks types' do
      expect {
        test_class.hello_world('Noah', '24')
      }.to raise_error(TypedRuby::WrongArgumentType)
    end

    it 'checks argument length' do
      expect {
        test_class.hello_world('Noah', 24, true)
      }.to raise_error(TypedRuby::MissingTypeDefinition)

      expect {
        test_class.hello_world('Noah')
      }.to raise_error(TypedRuby::InvalidArgumentLength)
    end
  end
  

  context "bad method structures" do
    let (:test_class) { MyBadClass.new }

    it 'checks the return value' do
      expect {
        test_class.hello_world('Noah', 24)
      }.to raise_error(TypedRuby::WrongReturnType)
    end

  end
end
