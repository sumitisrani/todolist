class  ProjectsController< ApplicationController
  
  def index
   @projects = Project.all
  end 
  
  def new
   @project=Project.new
  end

  def create
    @project=Project.new(params[:project])
    @project.user_id = current_user.id
    if @project.save
      flash[:notice]="project created sucessfully"   
      render 'devise/sessions/create'
    else
      render 'new'
    end
  end

  def show
    @project=Project.find(params[:id])
    @project_id = params[:id]
  end
  
  
  def allotment
    @project_id = params[:id]
    @upa = UserProjectAssignment.where(:project_id => @project_id).pluck(:user_id)
  end
  
  def assign
    
    if params[:role] == "1"
      @role="admin"
    else    
      @role="volunteer" 
    end  
    @upa = UserProjectAssignment.new(:user_id => params[:name], :project_id => params[:id],:role => @role)
    if @upa.save
      flash[:notice] = "user assigned sucessfully"
      redirect_to :action => :index
    else
      render 'assign'
      flash[:notice] = "user assigned not sucessfully"
    end  
  end
  
  def destroy
    project_id = params[:id]
    role = UserProjectAssignment.where('user_id = ? AND project_id = ?', current_user.id, project_id).first.role
    if role == "admin"
      Project.destroy(project_id)
      flash[:notice] = "project deleted successfully"
      render 'home/index'
    else
      flash[:notice] = "access denied only admin can delete the project"
      render 'home/index' 
    end
  end
  
  def edit
    debugger
    project_id = params[:id]
    role = UserProjectAssignment.where('user_id = ? AND project_id = ?', current_user.id, project_id).first.role
    if role == "admin"
      
      @project = Project.where(:id => project_id).first
    else
      flash[:notice] = "access denied only admin can edit the project"
      render 'home/index' 
    end
  
  end
  
  def update
  end

end
