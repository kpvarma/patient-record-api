class User < ActiveRecord::Base

  # including Password Methods
  has_secure_password

  # Constants
  EXCLUDED_JSON_ATTRIBUTES = [:password_digest, :created_at, :updated_at]
  SESSION_TIME_OUT = 30.minutes

  validates :name, :presence=> true, length: { in: 3..256 }
  validates :password, :presence=> true, format: { with: /\A(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9!@$#&*_\.,;:])/, min_length: 8, max_length: 256, message: "Password requires one capital letter, one special character, one numeral, minmum 8 characters and maximum 256 characters" }
  validates :password, confirmation: true, unless: Proc.new { |a| a.password.blank? }

  # ------------------
  # Instance variables
  # ------------------

  # Exclude some attributes info from json output.
  def as_json(options={})
    options[:except] ||= EXCLUDED_JSON_ATTRIBUTES
    super(options)
  end

  def start_session
    self.auth_token = SecureRandom.hex unless self.auth_token
    self.token_created_at = Time.now
    self.sign_in_count = self.sign_in_count ? self.sign_in_count + 1 : 1
    self.last_sign_in_at = self.current_sign_in_at
    self.save
  end

  def end_session
    self.update_attributes auth_token: nil, token_created_at: nil
  end

  def token_expired?
    return self.token_created_at.nil? || (Time.now > self.token_created_at + SESSION_TIME_OUT)
  end

end
