class Answer < ApplicationRecord
  include Commentable

  belongs_to :question
  belongs_to :user

  has_many :attachments, as: :attachmentable, dependent: :destroy

  accepts_nested_attributes_for :attachments, allow_destroy: true

  validates :body, presence: true

  default_scope -> { order(:created_at) }

  def error_messages
    errors.full_messages
  end
end
