class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  # allow_browser versions: :modern

  before_action :load_joint

  def load_joint
    @joint ||= Joint.friendly.find(params[:joint_id])
  rescue
    redirect_to new_joint_path
  end
end
