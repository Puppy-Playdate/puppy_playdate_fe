class SocialsFacade
  def self.create_social(data)
    response = SocialsService.create_social(data)
    response_body = JSON.parse(response.body, symbolize_names: true)
    if response.status == 201
      {
        status: response.status,
        social_id: response_body[:data][:id]
      }
    else
      {
        status: response.status,
        error: response_body[:error]
      }
    end
  end

  #show: specifc social
  def self.find_social(user_id, social_id)
    response = SocialsService.find_social(user_id, social_id)
    Social.new(response[:data])
  end

  #index: all socials
  def self.find_socials(user_id)
    response = SocialsService.find_socials(user_id)
    response[:data].map do |social|
      Social.new(social)
    end
  end
end