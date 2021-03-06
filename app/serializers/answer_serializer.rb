class AnswerSerializer < ActiveModel::Serializer
  attributes :id, :body, :question_id, :user_id, :attachments, :comments

  has_many :comments
  has_many :attachments, serializer: AttachmentSerializer

  delegate :attachments, to: :object
end
