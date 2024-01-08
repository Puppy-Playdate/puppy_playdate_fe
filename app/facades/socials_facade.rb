class SocialsFacade
  def self.create_social(data)
    response = SocialsService.create_social(data)
  end
end