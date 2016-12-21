class Group < ActiveRecord::Base
  # Associations
  has_many :members, dependent: :destroy
  has_many :todo_lists
  has_many :todo_items, through: :todo_lists

  # Password related
  attr_accessor :password_reset_token
  has_secure_password

  # Callbacks
  before_create :generate_registration_tokens

  def authenticated?(attribute:, token:)
    return false unless digest = self.send("#{attribute}_digest")
    BCrypt::Password.new(digest).is_password?(token)
  end

  def generate_secure_token
    SecureRandom.urlsafe_base64(36)
  end

  def create_digest_for(attribute:)
    token = generate_secure_token
    cost = Rails.env == "production" ? BCrypt::Engine::MAX_SALT_LENGTH : 4
    digest = BCrypt::Password.create(token, cost: cost)

    self.send("#{attribute}_token=", token)
    self.send("#{attribute}_digest", digest)
  end

  def generate_registration_tokens
    self.registration_tokens = [1,2].map { generate_secure_token }
  end

  def self.registration_tokens
    Group.all.pluck(:registration_tokens).flatten.compact
  end
end
