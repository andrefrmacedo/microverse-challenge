# frozen_string_literal: true

class User < ApplicationRecord
  validates :status, inclusion: { in: %w[Active Inactive] }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
end
