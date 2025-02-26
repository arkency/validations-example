require "rails_event_store"
require "aggregate_root"
require "arkency/command_bus"

Rails.configuration.to_prepare do
  Rails.configuration.event_store = RailsEventStore::Client.new
  Rails.configuration.command_bus = Arkency::CommandBus.new

  AggregateRoot.configure { |config| config.default_event_store = Rails.configuration.event_store }

  Rails.configuration.event_store.tap do |store|
    store.subscribe_to_all_events(RailsEventStore::LinkByEventType.new)
    store.subscribe_to_all_events(RailsEventStore::LinkByCorrelationId.new)
    store.subscribe_to_all_events(RailsEventStore::LinkByCausationId.new)
  end

  Rails.configuration.command_bus.tap do |bus|
    bus.register(
      IdentityAndAccess::RegisterUser,
      IdentityAndAccess::UserRegistration.new(Rails.configuration.event_store),
    )
  end
end
