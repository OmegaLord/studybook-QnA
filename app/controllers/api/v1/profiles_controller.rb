module Api
  module V1
    class ProfilesController < ApplicationController
      before_action :set_profile

      def show
        render json: @profile
      end

      def update
        # authorize @profile
        # flash[:notice] = 'Profile was successfully update.' if ProfilesUpdater.call(@profile, profile_params)
        # respond_with @profile, location: user_profile_path(current_user)
      end

      private

      def set_profile
        @profile = Profile.find_by(user_id: params[:user_id])
      end

      def profile_params
        params.require(:profile).permit(:first_name, :last_name, :avatar)
      end
    end

  end
end



