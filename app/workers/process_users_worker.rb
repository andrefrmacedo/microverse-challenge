# frozen_string_literal: true

class ProcessUsersWorker
  include Sidekiq::Worker

  def perform(user)
    ProcessUser.new(user:).call
  end
end
