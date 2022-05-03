class User < ApplicationRecord
    attr_reader :password

    validates :email, presence: true
    validates :email, uniqueness: true
    validates :password_digest, presence: { :message => 'Password can\'t be empty' }
    validates :password, length: { minimum: 6, allow_nil: true }
    before_validation :ensure_session_token

    has_many(
        :bands, 
        class_name: 'Band', 
        foreign_key: 'user_id', 
        primary_key: 'id', 
        dependent: :destroy 
    )

    has_many(
        :notes, 
        class_name: 'Note', 
        foreign_key: 'user_id', 
        primary_key: 'id', 
        dependent: :destroy
    )

    after_initialize do |user|
        if !user.session_token
            user.session_token = User.generate_session_token
        end
    end

    def self.generate_session_token
        SecureRandom::urlsafe_base64(16)
    end

    def self.find_by_credentials(email, password)
        user = User.where(email: email).first

        return nil if user.nil?

        user.is_password?(password) ? user : nil
    end

    def reset_session_token!
        self.session_token = self.class.generate_session_token
        self.save!
        self.session_token
    end

    def password=(password)
        @password = password
        self.password_digest = BCrypt::Password.create(password)
    end

    def is_password?(password)
        BCrypt::Password.new(self.password_digest).is_password?(password)
    end

    private

    def ensure_session_token
        self.session_token ||= self.class.generate_session_token
    end

end