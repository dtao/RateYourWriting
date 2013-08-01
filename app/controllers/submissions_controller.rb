class SubmissionsController < ApplicationController
  def index
    order = params[:sort] == 'rating' ? { :rating => :desc } : { :id => :desc }

    @submissions = Submission.published.order(order).limit(30).includes(:user)
    @submissions = @submissions.where(:kind => params[:kind]) if params.include?(:kind)
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

  def edit
    @submission = Submission.find(params[:id])
  end

  def update
    submission = Submission.find(params[:id])
    submission.update_attributes(submission_params)
    alert "Updated submission '#{submission.title}'!", :success
    redirect_to submission
  end

  def vote
    submission = Submission.find(params[:id])

    if (vote = current_user.vote_for(submission))
      if vote.rating.to_s != params[:rating].to_s
        vote.update_attributes(:rating => params[:rating])
        alert "Changed vote for '#{submission.title}' to #{params[:rating]}.", :success
      end

    else
      vote = Vote.create!({
        :user => current_user,
        :submission => submission,
        :rating => params[:rating]
      })

      alert "Rated '#{submission.title}' a #{params[:rating]}.", :success
    end

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

  def revisions
    @submission = Submission.find(params[:id])
    @revisions = @submission.revisions.order(:id => :desc)
  end

  private

  def submission_params
    params.required(:submission).permit(:kind, :title, :body, :published).merge(:user => current_user)
  end
end
