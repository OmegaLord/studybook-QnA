module Users
  class RegistrationsController < Devise::RegistrationsController
    def create
      super
      resource.create_profile if resource.save
    end
  end
end
