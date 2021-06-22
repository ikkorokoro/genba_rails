class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = current_user.tasks.order(created_at: :desc)
  end

  def show
  end

  def new
    @task = Task.new
  end

  def create 
    @task = current_user.tasks.new(task_params)
    if @task.save
      logger.debug "task: #{@task.attributes.inspect}"
      redirect_to @task, notice: "タスク「#{@task.name}」を登録しました"
    else
      render :new
    end
  end

  def edit
  end

  def update
  task.update!(task_params)
  redirect_to tasks_url, notice: "タスク「#{task.name}」を登録しました"
  end

  def destroy
    task.destroy!
    redirect_to tasks_url, notice: "タスク「#{task.name}を削除しました。」"
  end

  private

  def task_params
    params.require(:task).permit(:name, :description)
  end

  def set_task
    @task = current_user.tasks.find(params[:id])
  end
=begin 
  もし悪意あるユーザーがURLに他のユーザーが作った、taskのid入れて,もしそのデータが存在していれば
  簡単に閲覧、編集、削除することができてしまうのでcurrent_user.task.findと記述し,ユーザーのデータの中かデータを探すようにする
=end
=begin 
処理に対して変更がある場合、重複箇所は全て変更しないければいけなく、
手間やミスも起こしやすくなってしまうので重複を避けるように共通化を行う 
=end

end
