class JointsController < ApplicationController
  skip_before_action :load_joint

  def new
    @joint = Joint.new
  end

  def show
    @joint = Joint.friendly.find(params[:id])
  end

  def create
    @joint = Joint.new(joint_params)

    if @joint.save
      redirect_to @joint, notice: "Joint was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def joint_params
    params.expect(joint: [ :name ])
  end
end
