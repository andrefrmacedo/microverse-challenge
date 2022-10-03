# frozen_string_literal: true

class UsersWorker
  include Sidekiq::Worker

  def perform; end
end
