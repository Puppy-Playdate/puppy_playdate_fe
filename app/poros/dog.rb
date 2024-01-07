class Dog
  attr_reader :name, :breed, :age, :size, :neutered

  def initialize(data)
    @dog_id = data[:id].to_i
    @name = data[:attributes][:name]
    @breed = data[:attributes][:breed]
    @age = data[:attributes][:age]
    @size = data[:attributes][:size]
    @neutered = data[:attributes][:neutered]
  end
end