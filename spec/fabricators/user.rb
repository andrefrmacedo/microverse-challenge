# frozen_string_literal: true

Fabricator(:user) do
  first_name { Faker::Name.name }
  last_name { Faker::Name.name }
  email { Faker::Internet.email }
  status 'Active'
end
