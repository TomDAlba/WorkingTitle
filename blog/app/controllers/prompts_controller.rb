class PromptsController < ApplicationController
  before_action :set_prompt, only: [:show, :edit, :update, :destroy]

  # GET /prompts
  # GET /prompts.json
  def index
    @prompts = Prompt.all
  end

  # GET /prompts/1
  # GET /prompts/1.json
  def show
  end

  # GET /prompts/new
  def new
    @prompt = Prompt.new
  end

  # GET /prompts/1/edit
  def edit
  end

  # POST /prompts
  # POST /prompts.json
  def create
    logger.debug params
    @prompt = Prompt.new(prompt_params)
    @prompt.title = "Title goes here"
    @prompt.data = "Begin writing your prompt here"

    respond_to do |format|
      if @prompt.save
        format.html { redirect_to @prompt, notice: 'Prompt was successfully created.' }
        format.json { render action: 'show', status: :created, location: @prompt }
      else
        format.html { render action: 'new' }
        format.json { render json: @prompt.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /prompts/1
  # PATCH/PUT /prompts/1.json
  def update
    prompt = Prompt.new(params[:prompt])
    @prompt_old = Prompt.find(params[:id])
    @created = @prompt_old.created_at
    @old_id = @prompt_old.id
    @prompt_old.destroy

    prompt.title = params[:content][:title][:value]
    prompt.data = params[:content][:body][:value]
    prompt.id = @old_id
    prompt.created_at = @created


    if prompt.save!
        prompt.reload.id
        logger.debug "Working"
        
    end
    render text: ""
  end

  # DELETE /prompts/1
  # DELETE /prompts/1.json
  def destroy
    @prompt.destroy
    respond_to do |format|
      format.html { redirect_to prompts_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_prompt
      @prompt = Prompt.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def prompt_params
      params[:prompt]
    end
end
