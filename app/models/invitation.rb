# frozen_string_literal: true

class Invitation < ApplicationRecord
  belongs_to :user
end
