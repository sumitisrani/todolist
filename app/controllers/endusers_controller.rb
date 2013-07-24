class  EndusersController< ApplicationController

  def index
    @users=User.all
  end

end
