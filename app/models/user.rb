class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  belongs_to :plan
  has_one :profile
  #has_many :microposts, dependent: :destroy
  #has_many :active_relationships, class_name: "Relationship",
  #                                foreign_key: "follower_id",
  #                                dependent: :destroy
  #has_many :passive_relationships, class_name: "Relationship",
  #                                  foreign_key: "follower_id",
  #                                  dependent: :destroy
  #has_many :following, through: :active_relationships, source: :followed
  #has_many :followers, through: :passive_relationships, source: :follower
  #attr_accessor :stripe_card_token, remember_token, :activation_token, :reset_token
  #before_save :downcase_email
  #before_create :create_activation_digest
  #VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  #validates :email, presence: true, length: {maximum: 255},
  #                  format: {with: VALID_EMAIL_REGEX },
  #                  uniqueness: {case_sensitive: false}
  #has_secure_password
  #validates :password, presence: true, length: {minimum: 6}, allow_nil: true
  
  def save_with_payment
    if valid?
      customer = Stripe::Customer.create(description: email, plan: plan_id, source: stripe_card_token)
      self.stripe_customer_token = customer.id
      save!
    end
  end
end
