# frozen_string_literal: true

class ImportUsersWorker
  include Sidekiq::Worker

  def perform
    ImportUsers.new.call
  end
end
