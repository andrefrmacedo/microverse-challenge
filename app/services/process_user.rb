# frozen_string_literal: true

class ProcessUser
  def initialize(user:)
    @user = user
  end

  def call
    User.find_by(id: @user['id']) ? update : create
  end

  private

  def create
    User.create!(
      id: @user['id'],
      first_name: @user['first_name'],
      last_name: @user['last_name'],
      email: @user['email'],
      status: @user['status'],
      created_at: @user['created_at']
    )

    Rails.logger.info("User with id #{@user['id']} created")
  end

  def update
    User.update!(@user['id'], @user)

    Rails.logger.info("User with id #{@user['id']} updated")
  end
end
