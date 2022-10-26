# frozen_string_literal: true

require 'factory_bot'
require 'securerandom'

FactoryBot.define do
  factory :meibo_demographic, class: 'Meibo::Demographic' do
    initialize_with { new(**attributes) }

    sourced_id { SecureRandom.uuid }
  end
end
