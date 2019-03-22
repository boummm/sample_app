class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  attr_reader :remember_token

  validates :name, presence: true,
    length: {maximum: Settings.user_valid.max_length_name}
  validates :email, presence: true,
    length: {maximum: Settings.user_valid.max_length_email},
    format: {with: VALID_EMAIL_REGEX},
    uniqueness: {case_sensitive: false}
  validates :password, presence: true,
    length: {minimum: Settings.user_valid.min_length_password}
  validates :gender, presence: true, inclusion: %w(male female other)
  validates :date_of_birth,
    timeliness: {on_or_before: ->{Date.current}, type: :date}

  has_secure_password

  before_save :email_downcase

  class << self
    def digest string
      if cost = ActiveModel::SecurePassword.min_cost
        BCrypt::Engine::MIN_COST
      else
        BCrypt::Engine.cost
      end
      BCrypt::Password.create string, cost: cost
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  def remember
    @remember_token = User.new_token
    update remember_digest: User.digest(remember_token)
  end

  def authenticated? remember_token
    return false unless remember_digest
    BCrypt::Password.new(remember_digest).is_password? remember_token
  end

  def forget
    update remember_digest: nil
  end

  private

  def email_downcase
    email.downcase!
  end
end
