class Category < ApplicationRecord
  has_many :posts, dependent: :destroy

  scope :display_in_nav, -> {where(display_in_nav: true)}
end
