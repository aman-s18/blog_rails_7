class Post < ApplicationRecord
  validates :title, presence: true, length: { minimum: 5, maximum: 50 }
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_rich_text :description
  has_one :content, class_name: "ActionText::RichText", as: :record, dependent: :destroy
  has_noticed_notifications model_name: "Notification"
  has_many :notifications, through: :user
end
