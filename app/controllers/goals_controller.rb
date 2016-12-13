class GoalsController < ApplicationController
  before_action :require_login

  def index
    @goals = current_user.goals
    render :index
  end

  def new
    @goal = Goal.new
    render :new
  end

  def create
    @goal = Goal.new(goal_params)
    @goal.user_id = current_user.id
    if @goal.save
      flash[:notices] = ["Goal saved!"]
      redirect_to goal_url(@goal)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :new
    end
  end

  def update
    @goal = current_user.goals.find(params[:id])
    if @goal.update_attributes(goal_params)
      flash[:notices] = ["Goal updated!"]
      redirect_to goal_url(@goal)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :edit
    end
  end

  def edit
    @goal = Goal.find(params[:id])
    render :edit
  end

  def show
    @goal = Goal.find(params[:id])
    render :show
  end

  def destroy
    @goal = Goal.find(params[:id])
    @goal.destroy
    redirect_to goals_url
  end

  private
  def goal_params
    params.require(:goal).permit(:title, :private, :details, :completed)
  end
end
