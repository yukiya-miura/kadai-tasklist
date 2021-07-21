class TasksController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:show, :edit, :update, :destroy]
  

  def index
      @pagy, @tasks = pagy(current_user.tasks.order(id: :desc), items: 10)
  end

  def show
  end

  def new
      @task = Task.new
  end

  def create
      @task = current_user.tasks.build(task_params)
      
      if @task.save
          flash[:success] = 'Task が正常に作成されました'
          redirect_to @task
      else
        @pagy, @tasks = pagy(current_user.tasks.order(id: :desc))
          flash.now[:danger] = 'Task が作成されませんでした'
          render :new
      end
  end

  def edit
  end

  def update
      
      if @task.update(task_params)
          flash[:success] = 'Task は正常に更新されました'
          redirect_to @task
      else
          flash.now[:danger] = 'Task は更新されませんでした'
          render :edit
      end
  end

  def destroy
      @task.destroy
      
      flash[:success] = 'Task は正常に削除されました'
      redirect_to @task
  end
  
  
  private
  

  
  def task_params
      params.require(:task).permit(:content, :status)
  end
  
  def correct_user
    @task = Task.find(params[:id])
    if @task.user_id == current_user.id
    else
    redirect_to root_url
    end
  end
end