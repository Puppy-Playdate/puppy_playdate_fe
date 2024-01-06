class Dog
  attr_reader :name, :breed, :age, :size, :fixed

  def initialize(data)
    @dog_id = data[:id].to_i
    @name = data[:attributes][:name]
    @breed = data[:attributes][:breed]
    @age = data[:attributes][:age]
    @size = data[:attributes][:size]
    @fixed = data[:attributes][:fixed]
  end
end