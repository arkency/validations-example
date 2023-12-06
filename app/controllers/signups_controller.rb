class SignupsController < ApplicationController
  def new = render :new, locals: { signup: NewSignup.new }

  def create
    new_signup = NewSignup.new(signup_params)
    if new_signup.valid?
      redirect_to signups_path
    else
      render :new, locals: { signup: new_signup }, status: :unprocessable_entity
    end
  end

  def index = ()

  private

  def signup_params = params.require(:signup).permit(:email, :password)
end
