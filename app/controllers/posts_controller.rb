class PostsController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show, :add_like]
  load_and_authorize_resource :class => false, :except => [:index, :show, :add_like]
  # GET /posts
  # GET /posts.json
  def index
    @posts_draft = Post.select('id,title').draft(current_user)
    @posts_visible = Post.select('id,created_at,title,likes,body').visible(current_user)

    respond_to do |format|
      if current_user.present?
        format.html{ render :index, layout: 'backend' }
      else
        redirect_to root_path
        #format.html{ render :template => "posts/fe/index"}
      end
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @user = User.find_by_subdomain!(request.subdomain)
    if params[:id].present?
      @post = Post.find(params[:id])
    else
      @posts = Post.visible(@user).page params[:page]
    end

    respond_to do |format|
      #if current_user.present?
      #  format.html # show.html.erb
      #else
        if params[:id].present?
          format.html{ render :template => "posts/fe/show_post", layout: 'blog'}
        else
          format.html{ render :template => "posts/fe/show", layout: 'blog'}
      #  end
      end
    end
  end

  # GET /posts/new
  # GET /posts/new.json
  def new
    @post = Post.new
    @post.user_id = current_user.id

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
    respond_to do |format|
        format.html { render :edit, notice: 'Post was successfully created.', layout: "backend" }
    end
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(params[:post])

    respond_to do |format|
      if @post.save
        format.html { redirect_to posts_path, notice: 'Post was successfully created.' }
      else
        format.html { render action: "new" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.json
  def update
    @post = Post.find(params[:id])
    
    if params[:preview].to_s == "true"
      @user = current_user
      @post = Post.new(params[:post])
      @post.created_at = DateTime.now
      respond_to do |format|
        format.html { render :template => "posts/fe/show_post", layout: "blog" }
      end
    else
      respond_to do |format|
        if @post.update_attributes(params[:post])
          format.html { redirect_to posts_path, notice: 'Post was successfully updated.' }
        else
          format.html { render action: "edit" }
        end
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_path }
    end
  end

  #add_like_post GET    /posts/:id/add_like(.:format)           posts#add_like
  def add_like
    post = Post.find(params[:id])
    post.add_like
    render nothing: true
  end
  
  def preview
    @user = current_user
    @post = Post.find(params[:id])
    respond_to do |format|
        format.html { render :template => "posts/fe/show_post", layout: "blog" }
    end
  end

   def add_image
     @pic = PicturesPost.new
     tmp_file =  FilelessIO.new(Base64.decode64(params[:image]))
     tmp_file.original_filename = "#{Time.now.to_i.to_s}.#{params[:format_image].to_s}"
     @pic.image = tmp_file
     @pic.save
     render json: {filename: @pic.image.url.gsub(/\.s3\.amazonaws\.com/,'')}
   end
end

 class FilelessIO < StringIO
     attr_accessor :original_filename
 end
