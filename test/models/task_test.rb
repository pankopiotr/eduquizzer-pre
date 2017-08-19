require 'test_helper'

class TaskTest < ActiveSupport::TestCase
  def setup
    @task = Task.new(name: 'Apples', task_type: 'close-ended', category: 'test',
                     description: 'Are apples blue?',
                     correct_solutions: %w[no nope false],
                     wrong_solutions: %w[yes definitely true], score: 1,
                     deleted: false, mathjax: false, random: true,
                     no_random_solutions: 4, min_no_random_correct_solutions: 1,
                     user_id: '1')
  end

  test 'should validate task' do
    assert @task.valid?
  end

  test 'should not validate empty name' do
    @task.name = ''
    refute @task.valid?
  end

  test 'should not validate empty score' do
    @task.score = nil
    refute @task.valid?
  end

  test 'should not validate empty task type' do
    @task.task_type = ''
    refute @task.valid?
  end

  test 'should not validate empty author' do
    @task.user_id = ''
    refute @task.valid?
  end

  test 'should not validate empty solutions' do
    @task.correct_solutions = []
    @task.wrong_solutions = []
    refute @task.valid?
  end

  test 'should validate presence of only one type of solutions' do
    @task.correct_solutions = []
    @task.no_random_solutions = 2
    @task. min_no_random_correct_solutions = 0
    assert @task.valid?
  end

  test 'should not validate duplicated name' do
    @copycat_task = @task.dup
    @task.save
    refute @copycat_task.valid?
  end

  test 'should not validate number of random solutions greater then overall solutions count' do
    @task.no_random_solutions = 7
    refute @task.valid?
  end

  test 'should not validate number of random solutions being negative or equal to 0' do
    @task.no_random_solutions = 0
    refute @task.valid?
  end

  test 'should validate nil number of random solutions' do
    @task.no_random_solutions = nil
    assert @task.valid?
  end

  test 'should not validate minimal number of correct solutions greater then overall correct solutions count' do
    @task.min_no_random_correct_solutions = 4
    refute @task.valid?
  end

  test 'should not validate minimal number of correct solutions being negative' do
    @task.min_no_random_correct_solutions = -1
    refute @task.valid?
  end

  test 'should validate nil minimal number of correct solutions' do
    @task.min_no_random_correct_solutions = nil
    assert @task.valid?
  end

  test 'should clean random options if task is not randomized' do
    @task.random = false
    @task.save
    assert_nil Task.find_by(name: 'Apples').no_random_solutions
    assert_nil Task.find_by(name: 'Apples').min_no_random_correct_solutions
  end
end
