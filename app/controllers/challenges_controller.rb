class ChallengesController < ApplicationController

  skip_before_action :verify_authenticity_token

  def new
    @challenge = Challenge.new
    @challenge.user_id = @current_user.id
  end

  def create
    challenge = Challenge.create(challenge_params)
    challenge.user_id = @current_user.id
    challenge.save
    redirect_to challenge_path(challenge.id)
  end

  def index
    @challenges = Challenge.all.reverse
    @random = get_random(@challenges)
  end

  def show
    @challenge = Challenge.find params[:id]
    @next = next_chall(Challenge.all, @challenge)
    @solved = @challenge.solutions.map  { |x| x.user_id }
    if @current_user.present?
      @solutions = @current_user.solutions
      @solution = show_current_solution(@solutions, params[:id])
    end
    if @challenge.solutions.length > 0
      solved_rate = @challenge.solutions.map  { |x| x.score }
      @solved_rate = (solved_rate.reduce(:+))/solved_rate.length
      @difficulty = difficulty_rating(@solved_rate)
    end
  end

  def edit
    @challenge = Challenge.find params[:id]
  end

  def update
    @challenge = Challenge.find params[:id]
    @challenge.save
    if @challenge.update(challenge_params)
      redirect_to( challenge_path( @challenge.id ) )
    else
      flash[:errors] = @challenge.errors.full_messages
      render :edit
    end
  end

  def destroy
    challenge = Challenge.find params[:id]
    challenge.destroy
    redirect_to challenges_path
  end

  private
  def challenge_params
    params.require(:challenge).permit(:name, :description, :user_id)
  end

  def get_random(arr)
    arr.sample
  end

  def next_chall (arr, challenge)
    chall_index = arr.index(challenge)
    if challenge == arr.last
      arr.first
    else
      arr[chall_index + 1]
    end
  end

  def show_current_solution (arr, num)
    arr.each do |element|
      if element.id == num
        element
      end
    end
  end

  def difficulty_rating(rating)
    rate = rating.to_i
    case
    when rate >= 75
      "Easy"
    when rate < 75.0 && rate >= 50
      "Medium"
    when rate < 50 && rate >= 25
      "Hard"
    when rate < 25
      "Diabolical"
    end
  end
end
