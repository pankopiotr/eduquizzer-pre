module TasksHelper
  private

    def task_params
      params.require(:task).permit(:name, :task_type, :category, :description,
                                   :asset, :score, :mathjax, :random,
                                   :no_random_solutions,
                                   :min_no_correct_solutions,
                                   correct_solutions: [], wrong_solutions: [])
    end
end