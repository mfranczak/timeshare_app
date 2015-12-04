class ActivitiesController < ApplicationController
  before_action :require_login

  def index
    activities = Activity.where({ user: current_user }).order(when: :desc)

    @weekly_breakdown = GroupsBreakdown.new(activities)
    @daily_breakdown = DailyBreakdown.new(activities)
  end

  def new
    @activity = Activity.new
    @activity_types = Activity::TYPES
  end

  def create
    @activity = Activity.new activity_params
    @activity.user = current_user
    
    if @activity.valid?
      @activity.save
      redirect_to activities_path
    else
      @activity_types = Activity::TYPES
      render :new
    end
  end

  def destroy
    @activity = Activity.find_by(user: current_user, id: params[:id])
    @activity.destroy if @activity
    redirect_to activities_path
  end

  private
  def activity_params
    params[:activity].permit(:what, :when, :length) if params[:activity]
  end
end
