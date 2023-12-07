class SignupsProjection
  Signup = Data.define(:email)

  def initialize(event_store) = @event_store = event_store

  def all
    event_store
      .read
      .stream("users").to_a
      .each_with_object([]) { |event, signups| signups << Signup.new(event.data.fetch(:email)) }
  end

  private attr_reader :event_store
end
