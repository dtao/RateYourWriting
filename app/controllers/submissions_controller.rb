class SubmissionsController < ApplicationController
  def index
    options = {
      :include => 'user',
      :order => 'id desc',
      :limit => 30
    }

    options[:conditions] = { :kind => params[:kind] } if params.include?(:kind)

    @submissions = Submission.all(options)
  end

  def show
    @submission = Submission.find(params[:id])
    @current_vote = logged_in? && current_user.vote_for(@submission).try(:rating)
    @comments = @submission.comments(:order => 'id asc')
  end

  def new
    @submission = Submission.new
  end

  def create
    submission = Submission.create!(submission_params)
    alert "Created submission '#{submission.title}'!", :success
    redirect_to submission
  end

  def vote
    submission = Submission.find(params[:id])

    vote = Vote.create!({
      :user => current_user,
      :submission => submission,
      :rating => params[:rating]
    })

    alert "Rated '#{submission.title}' a #{params[:rating]}.", :success
    redirect_to submission
  end

  def comment
    submission = Submission.find(params[:id])

    comment = Comment.create!({
      :user => current_user,
      :submission => submission,
      :content => params[:comment]
    })

    alert "Commented on '#{submission.title}'.", :success
    redirect_to submission
  end

  private

  def submission_params
    params.required(:submission).permit(:kind, :title, :body).merge(:user => current_user)
  end
end
