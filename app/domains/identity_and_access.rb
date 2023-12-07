module IdentityAndAccess
  RegisterUser = Data.define(:email, :password)

  UserRegistered = Class.new(RailsEventStore::Event)

  UserAlreadyRegistered = Class.new(StandardError)

  class UserRegistration
    def initialize(event_store) = @event_store = event_store

    def call(command)
      event = UserRegistered.new(data: { email: command.email })
      check_email_uniqueness(event)
      event_store.link(event.event_id, stream_name: "users")
    end

    private

    attr_reader :event_store

    def check_email_uniqueness(event)
      event_store.publish(event, stream_name: "users_uniqueness$#{event.data.fetch(:email)}", expected_version: :none)
    rescue RubyEventStore::WrongExpectedEventVersion
      raise UserAlreadyRegistered
    end
  end
end
