module Api
    module V1
        class ArticlesController < ApplicationController

            #GET - list of articles
            def index
                articles = Article.order('created_at DESC');
                render json: {status:'SUCCESS', message:'Loaded articles', data:articles}, status: :ok
            end

            #GET - Specific Article   
            def show
                article = Article.find(params[:id])
                render json: {status:'SUCCESS', message:'Loaded articles', data:article}, status: :ok
            end

            #POST - New article
            def create
                article = Article.new(article_params)
                
                if article.save
                  render json: {status: 'SUCCESS', message:'Saved article', data:article},status: :ok
                else
                  render json: {status: 'ERROR', message:'Article not saved', data:article.errors},status: :unprocessable_entity
                end
            end

            #DELETE - Destroying article using id as a param
            # localhost:3000/api/v1/articles/15

            def destroy
                article = Article.find(params[:id])
                article.destroy
                render json: {status: 'SUCCESS', message:'Deleted article', data:article},status: :ok

            end    

            #PUT - Updating article using id as a param
            def update
            article = Article.find(params[:id])
                if article.update_attributes(article_params)
                    render json: {status: 'SUCCESS', message:'Updated article', data:article},status: :ok
                else
                    render json: {status: 'ERROR', message:'Article not updated', data:article.errors},status: :unprocessable_entity
                end    
            end    
            private
            def article_params
                params.permit(:title, :body)
            end    
        end        
    end
end                
