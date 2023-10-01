class Api::V1::Admin::AdminsController < BaseUsersController

  include CheckRole
  before_action :check_role_admin, only: [:register, :login]

  def login
    super
  end

  def register
    super
  end

  def index
    super
  end

  def show
    super
  end

  def update
    super
  end

  def destroy
    super
  end
end