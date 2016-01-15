class TopicsController < ApplicationController
  before_action :set_topic, only: [:show, :edit, :update, :destroy]

  # GET /topics
  # GET /topics.json
  def index
    #@topics = Topic.all
    redirect_to group_path(:id => params[:group_id])
  end

  # GET /topics/1
  # GET /topics/1.json
  def show
    @posts = Post.all
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @post.topic_id = params[:topic_id]
  #  @post.group_id = params[:group_id]

      if @post.save
        redirect_to '/'
      end
  end

  # GET /topics/new
  def new
    @topic = Topic.new
  end

  def create_post
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @post.topic_id = params[:topic_id]
  #  @post.group_id = params[:group_id]

      if @post.save
        redirect_to '/'
      end

  end



  # GET /topics/1/edit
  def edit
  end

  # POST /topics
  # POST /topics.json
  def create
    @topic = Topic.new(topic_params)
    @topic.user_id = current_user.id
    @topic.group_id = params[:group_id]

    respond_to do |format|
      if @topic.save
        format.html { redirect_to group_topic_path(:id => @topic.id), notice: 'Topic was successfully created.' }
        format.json { render :show, status: :created, location: @topic }
      else
        format.html { render :new }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /topics/1
  # PATCH/PUT /topics/1.json
  def update
    respond_to do |format|
      if @topic.update(topic_params)
        format.html { redirect_to group_topic_path(:id => @topic.id), notice: 'Topic was successfully updated.' }
        format.json { render :show, status: :ok, location: @topic }
      else
        format.html { render :edit }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /topics/1
  # DELETE /topics/1.json
  def destroy
    @topic.destroy
    respond_to do |format|
      format.html { redirect_to group_path(:id => params[:group_id]), notice: 'Topic was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_topic
      @topic = Topic.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def topic_params
      params.require(:topic).permit(:name, :description, :group_id, :user_id)
    end
end

private
def post_params
  params.require(:content).permit(:content)
end
