# frozen_string_literal: true

require 'solidus_core'
require 'solidus_support'

module SolidusAcima
  class Engine < Rails::Engine
    include SolidusSupport::EngineExtensions

    isolate_namespace ::Spree

    engine_name 'solidus_acima'

    initializer "solidus_acima.add_static_preference", after: "spree.register.payment_methods" do |app|
      app.config.spree.payment_methods << SolidusAcima::PaymentMethod
      Spree::PermittedAttributes.source_attributes.concat [:lease_id, :lease_number, :checkout_token]
    end

    # use rspec for tests
    config.generators do |g|
      g.test_framework :rspec
    end
  end
end
