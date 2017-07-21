class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  # GET /articles
  # GET /articles.json
  def index
    @articles = Article.all
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
  end

  # GET /articles/new
  def new
    @article = Article.new
     @articles = Article.all.order(created_at:  :desc)
@users=User.all
  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles
  # POST /articles.json
  def create
    @article = Article.new(article_params)

 @article.user_id=current_user.id
    respond_to do |format|
      if @article.save

 @art_id= @article.id
       @user_idss = params[:vvv ]
       if @user_idss != nil
         
     
        @user_idss.each do |userid|
         Tagging.create(:user_id => userid,article_id: @art_id) 
  
        end
          end

        format.html { redirect_to new_article_path, notice: 'Article was successfully created.' }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to @article, notice: 'Article was successfully updated.' }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url, notice: 'Article was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

    def upvote
    
      @article = Article.find(params[:id])
      @article.liked_by current_user
      redirect_to new_article_path
  end

 def downvote
      @article = Article.find(params[:id])
      @article.downvote_from current_user

redirect_to new_article_path
      
  end

  def userprofile
      @users = User.all.where.not(id: current_user)
  end
  def invite
    Friendship.create( friendable_id: current_user.id,friend_id: params[:id].to_i ,pending: nil)
    flash[:notice] = "friend request sent to #{User.where(id: params[:id].to_i).first.email}"
    redirect_to article_userprof_path
  end
  def approve

    current_user.approve (User.find(params[:ida]))
      flash[:notice] = "now you are friend with #{User.where(id: params[:ida].to_i).first.email}"

     redirect_to article_userprof_path
  end
def delete_request
  Friendship.where(friendable_id:   params[:ida], friend_id: current_user.id, pending: nil).first.destroy
   flash[:notice] = "friend request deleted"
    redirect_to article_userprof_path
end
def all_frinds
  @all_frinds= current_user.friends
  
end

def follow

  Follow.create(follower_id: current_user.id, following_id: params[:id].to_i) 

  redirect_to article_userprof_path
  
end

def unfollow
   Follow.where(follower_id: current_user.id, following_id: params[:id].to_i).first.destroy 

   redirect_to article_userprof_path
  
end
  



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params.require(:article).permit(:title)
    end
end
