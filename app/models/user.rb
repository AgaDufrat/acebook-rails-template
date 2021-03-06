# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships

  has_many :inverse_friendships,
           class_name: 'Friendship',
           foreign_key: 'friend_id'
  has_many :inverse_friends, through: :inverse_friendships, source: :user
  has_many :post_likes, dependent: :destroy
  has_many :comment_likes, dependent: :destroy

  has_attached_file :avatar,
                    styles: { medium: '300x300>', thumb: '100x100>' },
                    default_url: '/images/defaultprofileimage.png'
  validates_attachment_content_type :avatar, content_type: %r{\Aimage/.*\z}
end
