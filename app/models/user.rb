# frozen_string_literal: true

class User < ApplicationRecord
  paginates_per 20

  validates :status, inclusion: { in: %w[Active Inactive] }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  scope :filter_by_status, ->(status) { where(status:) }
end
