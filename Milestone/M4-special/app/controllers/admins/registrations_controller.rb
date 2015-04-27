class Admins::RegistrationsController < Devise::RegistrationsController

  prepend_before_filter :require_no_authentication, only: [:cancel]
  prepend_before_filter :authenticate_scope!, only: [:new,:create, :edit, :update, :destroy]

  protected
  def sign_up(resource_name,resource)

  end

  protected

  def after_sign_up_path_for(resource)
    root_path
  end
end