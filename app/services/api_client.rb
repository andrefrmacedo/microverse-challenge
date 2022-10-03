# frozen_string_literal: true

require 'rest-client'

class ApiClient
  BASE_URL = 'https://microverse-api-app.herokuapp.com'

  def get_users(limit:, offset:)
    url = "#{BASE_URL}/users?limit=#{limit}&offset=#{offset}"

    RestClient.get(url, headers)
  end

  private

  def headers
    { Authorization: Rails.application.credentials.fetch(:api_key) }
  end
end
