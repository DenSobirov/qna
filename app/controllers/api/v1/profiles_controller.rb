class Api::V1::ProfilesController < Api::V1::BaseController
  skip_authorization_check

  def index
    respond_with(@profiles = User.where.not(id: current_resource_owner.id))
  end

  def me
    respond_with current_resource_owner
  end
end
