require 'typed_ruby/typed_class'

class MyTestClass < TypedRuby::TypedClass

  deft :hello_world, :string, :integer, return: :nil do |name, age|
    puts "Hello, I am #{name} and I am #{age} years old!"
  end

end

RSpec.describe 'TypedClass' do
  let (:test_class) { MyTestClass.new }

  it 'can call a method' do
    expect {
      test_class.hello_world('Noah', 24)
    }.not_to raise_error
  end

  it 'checks types' do
    expect {
      test_class.hello_world('Noah', '24')
    }.to raise_error
  end

  it 'checks argument length' do
    expect {
      test_class.hello_world('Noah', 24, true)
    }.to raise_error
  end

  #it 'checks the return value' do
  #end
  
end
