class  TasksController< ApplicationController
  
  def index
    
    @task=Task.where(:project_id=>params[:project_id])
  end
  def new
    
    @task=Task.new
    @project_id=params[:project_id] 
  end
  
  def create
    
    @task=Task.new(params[:task])
    
      if @task.save
        flash[:notice]="task created successfully" 
        redirect_to project_path(@task.project_id)
      else
        render 'create'
      end
  end
  def show
    
    @project_id = params[:project_id]
    @task=Task.where(:id => params[:id]).first
    @comment=Comment.where(:task_id => params[:id])
  
  end
end  
