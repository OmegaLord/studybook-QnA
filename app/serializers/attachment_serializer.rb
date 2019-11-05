class AttachmentSerializer < ActiveModel::Serializer
  attributes :id, :url, :filename

  def url
    object.file.url
  end

  def filename
    object.file.identifier
  end
end
