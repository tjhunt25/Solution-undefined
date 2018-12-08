class SolutionsController < ApplicationController

  skip_before_action :verify_authenticity_token


  def new
    @challenge = Challenge.find params[:id]
    if @current_user.present?
      @solution = Solution.create(
        challenge_id: @challenge.id,
        user_id: @current_user.id,
        score: 0
      )
      redirect_to edit_solution_path @solution.id
    else
      redirect_to solutions_trial_path(params: {id: @challenge.id})
    end
  end

  def create
    solution = Solution.new solution_params
    if @current_user.present?
      solution.user_id = @current_user.id #should be 'current user'
      solution.save
      redirect_to controller: 'solutions', action: 'show', id: solution.id
    else
      redirect_back fallback_location: request.referrer
    end
  end

  def edit
    @solution = Solution.find(params[:id])
    @challenge = Challenge.find(@solution.challenge_id)
    @data = getData(@challenge).to_json.html_safe
  end

  def trial
    @challenge = Challenge.find(params[:id])
    @data = getData(@challenge).to_json.html_safe
  end

  def update
    solution = Solution.find(params[:id])
    solution.update(
      solution_params
    )
    # redirect_to edit_solution_path params[:id]
  end

  def index
    @solutions = Solution.all
  end

  def show
    @comment = Comment.create({body:params[:body]})
    @solution = Solution.find(params[:id])
    @challenge = Challenge.find(@solution.challenge_id)
    @data = getData(@challenge).to_json.html_safe
  end

  def destroy
    solution = Solution.find(params[:id])
    solution.destroy()
    redirect_to controller: 'users', action: 'show', id: @current_user.id
  end

  private

  def solution_params
    params.permit(:code, :challenge_id, :score)
  end

  def getData(challenge)
    data = challenge.test_pairs
    inputs = []
    outputs = []
    data.each{ |pair|
      if pair.integer_input_type? # if the input is meant to be a number, convert it to a float.
        input = pair.input.to_f;
      elsif pair.string_input_type? # if its meant to be a string, leave it as it is.
        input = pair.input;
      else                        # else it's meant to be an array, so split it on a pipe.
        input = pair.input.split('|');
      end
      inputs.push(input);

      if pair.output_integer? # if the input is meant to be a number, convert it to a float.
        output = pair.output.to_f;
      elsif pair.output_string? # if its meant to be a string, leave it as it is.
        output = pair.output;
      else                        # else it's meant to be an array, so split it on a pipe.
        output = pair.output.split('|');
      end
      outputs.push(output);
    };
    data = {inputs: inputs , outputs: outputs}
  end
end
