class UserDecorator < Draper::Decorator
  delegate_all

  def first_name
    object.name.split(' ').first
  end

  def last_name
    object.name.split(' ').last
  end
end
