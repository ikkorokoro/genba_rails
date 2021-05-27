class TasksController < ApplicationController
=begin 
  もし悪意あるユーザーがURLに他のユーザーが作った、taskのid入れて,もしそのデータが存在していれば
  簡単に閲覧、編集、削除することができてしまうのでcurrent_user.task.findし記述してデータを探すようにする
=end
  def index
    @tasks = current_user.tasks.order(created_at: :desc)
  end

  def show
    @task = current_user.tasks.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def create 
    @task = current_user.tasks.new(task_params)
    if @task.save
      redirect_to @task, notice: "タスク「#{@task.name}」を登録しました"
    else
      render :new
    end
  end

  def edit
    @task =current_user.tasks.find(params[:id])
  end

  def update
  task = current_user.tasks.find(params[:id])
  task.update!(task_params)
  redirect_to tasks_url, notice: "タスク「#{task.name}」を登録しました"
  end

  def destroy
    task = Task.find(params[:id])
    task.destroy!
    redirect_to tasks_url, notice: "タスク「#{task.name}を削除しました。」"
  end

  private

  def task_params
    params.require(:task).permit(:name, :description)
  end
end
