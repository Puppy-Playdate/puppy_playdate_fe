class UserFacade 
  def self.get_by_id(id)
    user = UserService.find_by_id(id)[:data][:attributes]
    User.new(user)
  end
end 