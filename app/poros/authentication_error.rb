class AuthenticationError
  attr_reader :name, :status, :error

  def initialize(data)
    @name = false
    @status = data[:status]
    @error = data[:error]
  end
end