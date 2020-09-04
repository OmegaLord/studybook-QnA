module Api
  module V1
    class ProfilesController < ApiController
      before_action :set_profile

      def show
        render json: @profile
      end

      def update
        authorize @profile
        ProfilesUpdater.call(@profile, profile_params)
        respond_with @profile
      end

      private

      def set_profile
        @profile = Profile.find_by(user_id: params[:user_id])
      end

      def profile_params
        params.require(:profile).permit(:first_name, :last_name, avatar: [:data, :filename, :type])
      end
    end
  end
end
