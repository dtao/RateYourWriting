class SubmissionsController < ApplicationController
  def index
    @submissions = Submission.all(:order => 'id desc', :limit => 30)
  end

  def show
    @submission = Submission.find(params[:id])
  end

  def new
    @submission = Submission.new
  end

  def create
    @submission = Submission.create!(submission_params)
    alert "Created submission '#{@submission.title}'!", :success
    redirect_to @submission
  end

  private

  def submission_params
    params.required(:submission).permit(:title, :body).merge(:user => current_user)
  end
end
