class UserFacade 
  def self.get_by_id(id)
    user_attributes = UserService.find_by_id(id)[:data][:attributes]
    user = User.new(user_attributes)
    UserDecorator.decorate(user)
  end
end 