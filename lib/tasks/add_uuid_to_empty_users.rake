# frozen_string_literal: true

namespace :add_uuid_to_empty_users do
  desc 'TODO'
  task add_uuid: :environment do
    User.where(uuid: nil) do |user|
      user.uuid = UUID.generate
      user.save
    end
  end
end
