class ProjectsController < ApplicationController
  def index
    @projects = Project.find(:all)
  end

  def by_prompt
    @prompt = Prompt.find(params[:prompt])
    logger.debug Project.exists?(prompt_id: 7)
    @projects = Project.find(:all, :conditions => { :prompt_id => @prompt.id})
  end
  
  def show
    @project = Project.find(params[:id])

    @p_id = @project.prompt_id
    @prompt = Prompt.find(@p_id)

  end
  
  def new
    @project = Project.new

  end
  
  def create
    logger.debug params
    @user = User.find(params[:user])
    @project = Project.new(params[:project])
    @project.user_id = @user.id
    @project.title = "Title"
    @project.body = "Enter your text here!"
    @project.prompt_id = params[:prompt]
    if @project.save
      flash[:notice] = "Successfully created project."
      redirect_to @project
    else

    end
  end
  
  def edit
    @project = Project.find(params[:id])


  end
  
  def update
    project = Project.new(params[:project])
    @project_old = Project.find(params[:id])
    @created = @project_old.created_at
    @old_id = @project_old.id
    @prompt = @project_old.prompt_id
    @project_old.destroy

    project.title = params[:content][:title][:value]
    project.body = params[:content][:body][:value]
    project.id = @old_id
    project.created_at = @created
    project.prompt_id = @prompt

    if project.save!
        project.reload.id
        logger.debug "Working"
        
    end
    render text: ""
  end
  
  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    flash[:notice] = "Successfully destroyed project."
    redirect_to projects_url
  end
end
