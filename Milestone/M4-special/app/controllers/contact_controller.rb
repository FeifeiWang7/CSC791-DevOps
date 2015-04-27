class ContactController < ApplicationController
  def view
    @users=User.order(:email)
    @admins=Admin.order(:email)
    @employers=Employer.order(:email)
  end
end
