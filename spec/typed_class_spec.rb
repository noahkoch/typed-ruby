require 'typed_ruby/typed_class'
require 'typed_ruby/exceptions'
require 'pry'

class MyGoodClass < TypedRuby::TypedClass

  deft :hello_world, String, Integer, return_type: NilClass do |name, age|
    puts "Hello, I am #{name} and I am #{age} years old!"
  end

  self_deft :hello_world, String, Integer, return_type: NilClass do |name, age|
    puts "Hello, I am #{name} and I am #{age} years old!"
  end

  deft :cant_access_this_method, return_type: Integer, private_method: true do
    42
  end

  deft :access_the_private_method, return_type: Integer do
    cant_access_this_method
  end

end

class MyBadClass < TypedRuby::TypedClass

  deft :hello_world, String, Integer, return_type: Boolean do |name, age|
    puts "Hello, I am #{name} and I am #{age} years old!"
  end

end

RSpec.describe 'TypedClass' do

  context "class methods" do
    context "proper method structures" do
      let (:test_class) { MyGoodClass }

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
  end

  context "instance methods" do
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

      context "private method" do
        it 'can access a private method' do
          expect{ test_class.cant_access_this_method }.to raise_error(NoMethodError)
          expect(test_class.access_the_private_method).to eq(42) 
        end
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
end
