class ProfilesUpdater
  extend Rails.application.routes.url_helpers

  class << self
    def call(object, params)
      profile_update object, params
    end

    private

    def profile_update(profile, params)
      profile.avatar.purge if params[:avatar]
      params[:avatar] = blob_base64(params[:avatar]) unless params[:avatar].is_a? ActionDispatch::Http::UploadedFile
      profile.update params if params.present?
    end

    def blob_base64(avatar)
      ActiveStorage::Blob.create_after_upload!(
        io: StringIO.new(Base64.decode64(avatar[:data].split(',')[1])),
        filename: avatar[:filename],
        content_type: avatar[:type]
      )
    end
  end
end
