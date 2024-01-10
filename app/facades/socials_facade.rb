class SocialsFacade
  def self.create_social(data)
    response = SocialsService.create_social(data)
  end

  def self.find_social(user_id, social_id)
    response = SocialsService.find_social(user_id, social_id)
    Social.new(response[:data])
  end

  def self.find_socials(user_id)
    response = SocialsService.find_socials(user_id)
    response[:data].each do |social|
      Social.new(social)
    end
  end
end