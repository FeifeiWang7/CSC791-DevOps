class RegistrationsController < Devise::RegistrationsController

  def create
    super
  end

  protected
  def sign_up(resource_name,resource)
    true
  end

  protected

  # def after_sign_up_path_for(resource)
  #   '0.0.0.0:3000/jobs'
  # end
end