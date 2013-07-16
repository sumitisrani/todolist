class CommentsController < ApplicationController

  def new
    
    project_id = params[:project_id]
    @task_id = params[:task_id]
    @user_id = current_user.id
    @comment = Comment.new
    
    @user_array=Task.where(:project_id => project_id).pluck(:user_id)
    if @user_array.include?(current_user.id)
      #render 'new'
    else
     flash[:notice]="access denied you are not permitted to comment on this task"  
     render 'home/index' 
    end
  end

  def create
    @comment=Comment.new(params[:comment])
      
      if @comment.save
        flash[:notice]="comment created succesfully"
        render 'home/index'
        
      else
         flash[:notice]="comment not created"
        render 'home/index'
         
      end
  end

end
