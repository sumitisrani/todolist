class  ProjectsController< ApplicationController
  
  def index
   @projects = Project.all
  end 
  
  def new
   @project = Project.new
  end

  def create
    @project = current_user.projects.new(params[:project])
    if @project.save
      flash[:notice] = "project created sucessfully"   
      render 'home/index'
    else
      flash[:notice] = "something went wrong" 
      render 'new'
    end
  end

  def show
    @project = Project.find(params[:id])
  end

  def allotment
    project = Project.where(:id => params[:id]).first
    @users = User.where('id not in (?)', project.users)
    unless @users.any?
      flash[:notice] = "no user remain left"
      redirect_to project_path(project.id)
    end
  end
  
  def assign
    role = Role.where(:name => params[:role])
    user = User.where(:id => params[:user_id]).first 
    if role.present? && user.present?
      user_project_assignment = user.user_project_assignments.new( :project_id => params[:id],:role => params[:role])
      if user_project_assignment.save
        flash[:notice] = "user assigned sucessfully"
        redirect_to :action => :index
      else
        render 'assign'
       flash[:notice] = "user assigned not sucessfully"
      end  
    else
      flash[:notice] = "invalid role or id of user " 
      redirect_to allotment_project_path(params[:id])
    end  
  end
  
  def destroy
    project_assignment = UserProjectAssignment.where('user_id = ? AND project_id = ? AND role = ?', current_user.id, params[:id], "admin").first  
    if project_assignment.present?
      if project_assignment.project.destroy
        flash[:notice] = "project deleted successfully"
        render 'home/index'
      else
        flash[:notice] = "access denied only admin can delete the project"
        render 'home/index' 
      end
    else
      flash[:notice] = "access denied only admin can delete the project"
      render 'home/index' 
    end 
  end
  
  def edit
    project_assignment = UserProjectAssignment.where('user_id = ? AND project_id = ? AND role = ?', current_user.id, params[:id], "admin").first
    if project_assignment.present?
      @project = project_assignment.project
    else
      flash[:notice] = "access denied only admin can edit the project"
      render 'home/index' 
    end
  end
  
  def update
    project = Project.where(:id => params[:id]).first
    if project.update_attributes(params[:project])
      flash[:notice] = "project updated successfully"
      render 'home/index'
    else
      flash[:notice] = "something went wrong"
    end
  end
end
