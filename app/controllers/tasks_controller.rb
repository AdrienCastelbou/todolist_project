class TasksController < ApplicationController
before_action :authenticate_user!
  def new
    @categories = Category.all
  end

  def create
    @task = Task.new(task_params)
    @category = Category.find(category_params)
    @task.category = @category
    
    if @task.save
      respond_to do |format|
        format.html { redirect_to root_path }
        format.js { }
      end
      flash[:notice] = "Task created"
    else
      redirect_to root_path
      flash[:notice] = "Please try again"
    end
  end

  def edit
    @task = Task.find(params[:id])
    @categories = Category.all

  end

  def update
    
    @task = Task.find(params[:id])
    @task.update(task_params)
    puts "@@@@@@@@"
    puts params
    if params[:status]
      if @task.status == true
        @task.update(status: false)
        puts @task.status
      else
        @task.update(status: true)
        puts @task.status
      end
    else 
      @task.update(status: false)
      puts @task.status
    end
    
    respond_to do |format|
      format.html { redirect_to root_path }
      format.js { }
    end
    flash[:notice] = "Task edited"
  end

  def index
    @tasks = Task.all
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    respond_to do |format|
      format.html { redirect_to root_path }
      format.js { }
      puts params
    end
  end


  private

  def task_params
    params.permit(:title, :deadline, :description)
  end

  def category_params
    params.require(:Category)
  end

end
