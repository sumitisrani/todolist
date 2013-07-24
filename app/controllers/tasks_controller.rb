class  TasksController< ApplicationController
  def index
    @task = Task.where(:project_id=>params[:project_id])
  end
  
  def new
    project_assignment = UserProjectAssignment.where('user_id = ? AND project_id = ? AND role = ?', current_user.id, params[:project_id], "admin").first
    if project_assignment.present?
      @task = Task.new
    else
      flash[:notice] = "access denied only admin can create the task"
      render 'home/index' 
    end
  end
  
  def create
    @task = Task.new(params[:task])
    if @task.save
      flash[:notice] = "task created successfully" 
      redirect_to project_path(@task.project_id)
    else
      flash[:notice] = "promblem occured during task creation"
      render 'home/index'
    end
  end
  
  def show
    @task = Task.where(:id => params[:id]).first
    @comment = @task.comments
  end
   
  def edit
    project_assignment = UserProjectAssignment.where('user_id = ? AND project_id = ? AND role = ?', current_user.id, params[:project_id], "admin").first
    if project_assignment.present?
      @task = Task.where(:id => params[:id]).first 
    else
      flash[:notice] = "access denied only admin can edit the task"
      render 'home/index' 
    end
  end
  
  def update
    task = Task.where("id = ?", params[:id]).first
    if task.update_attributes(params[:task])
      flash[:notice] = "task updated successfully"
      render 'home/index'
    else
      flash[:notice] = "something went wrong"
    end
  end
  
  def destroy
     project_assignment = UserProjectAssignment.where('user_id = ? AND project_id = ? AND role = ?', current_user.id, params[:project_id], "admin").first
    if project_assignment.present?
      Task.destroy(params[:id])
      flash[:notice] = "task deleted successfully"
      render 'home/index'
    else
      flash[:notice] = "access denied only admin can delete the task"
      render 'home/index' 
    end
  end
  
end  
