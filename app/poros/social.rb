class Social
  attr_reader :name, :description, :location, :event_date, :event_type

  def initialize(data)
    @id = data[:id].to_i
    @name = data[:attributes][:name]
    @description = data[:attributes][:description]
    @location = data[:attributes][:location]
    @event_date = data[:attributes][:event_date]
    @event_type = data[:attributes][:event_type]
  end
end