class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]  
  before_action :admin_user,     only: :destroy

  def index
    @users = User.paginate(page: params[:page])
    respond_to do |format|

      format.html # show.html.erb
      format.xml  { render :xml => @users }          
      format.json { render json: @users }

    end     
  end

  def show
    @user = User.find(params[:id])
    @books = @user.books.paginate(page: params[:page]) 

    respond_to do |format|

      format.html # show.html.erb
      format.xml  { render :xml => @user }          
      format.json { render json: @user }

    end       
  end

  def new
    @user = User.new  	
  end

  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        flash[:notice] = 'User was successfully created.'
        format.html { redirect_to(@user) }
        format.xml { render xml: @user }
      else
        format.html { render action: "new" }
        format.xml { render xml: @user }
      end
    end    
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end

    # Confirms the correct user.
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end    

    # Confirms an admin user.
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end    
end
