class SignupsController < ApplicationController
  def new
    render :new, locals: { signup: NewSignup.new }
  end

  def create
  end
end
