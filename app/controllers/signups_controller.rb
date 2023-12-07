class SignupsController < ApplicationController
  def new = render :new, locals: { signup: NewSignup.new }

  def create
    new_signup = NewSignup.new(signup_params)

    if new_signup.valid?
      command_bus.call(IdentityAndAccess::RegisterUser.new(new_signup.email, new_signup.password))

      redirect_to signups_path
    else
      render :new, locals: { signup: new_signup }, status: :unprocessable_entity
    end
  rescue IdentityAndAccess::UserAlreadyRegistered
    handle_this_rare_case_of_duplicate_email(new_signup)
  end

  def index = ()

  private

  def signup_params = params.require(:signup).permit(:email, :password)

  def command_bus = Rails.configuration.command_bus

  def handle_this_rare_case_of_duplicate_email(new_signup)
    new_signup.errors.add(:email, "has already been taken")
    render :new, locals: { signup: new_signup }, status: :unprocessable_entity
  end
end
