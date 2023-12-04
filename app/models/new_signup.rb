class NewSignup
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :email, :string
  attribute :password, :string

  def model_name
    ActiveModel::Name.new(nil, nil, 'Signup')
  end
end