class Post < ApplicationRecord
  include ActiveModel::Validations
  validates_with UrlValidator, attributes: [:url]

  belongs_to :user

  validates :title, presence: true, length: { minimum: 3, maximum: 300 }
  validates :url, presence: true, uniqueness: { case_sensitive: false }
end
