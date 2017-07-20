class EndorsesController < ApplicationController
	 def create
    @article = Article.find(params[:article_id])
    @endorse = @article.endorses.create(endorse_params)
    redirect_to new_article_path(@article)
  end
 
  private
    def endorse_params
      params.require(:endorse).permit(:title, :body)
    end
end
