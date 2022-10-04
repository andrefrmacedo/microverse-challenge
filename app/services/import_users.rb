# frozen_string_literal: true

class ImportUsers
  INCREMENT = 20

  def call
    count = 0

    loop do
      users = get_users(offset: INCREMENT * count)
      count += 1

      break if users.empty?

      users.each do |user|
        process_user(user:)
      end
    end
  end

  private

  def process_user(user:)
    ProcessUsersWorker.perform_async(user)
  end

  def get_users(offset:)
    JSON.parse(api_client.get_users(limit: INCREMENT, offset:))
  end

  def api_client
    @api_client ||= ApiClient.new
  end
end
