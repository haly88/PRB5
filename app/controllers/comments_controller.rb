class CommentsController < ApplicationController

	before_filter :load_commentable

  def index
  	@comments = @commentable.comments
  end

  def new
    @comment = @commentable.comments.new
  end

  # POST /locations
  # POST /locations.json
  def create
    binding.pry
    @comment = @commentable.comments.new(comment_params)
    respond_to do |format|
      if @comment.save
        format.html { redirect_to [@commentable, :comments], notice: 'Comment created.' }
      else
        format.html { render :new }
      end
    end
  end

  private

  def load_commentable
		klass = [Article, Photo, Event].detect { |c| params["#{c.name.underscore}_id"]}
		@commentable = klass.find(params["#{klass.name.underscore}_id"])
	end

	def comment_params
    params.require(:comment).permit(:content)
   end
end
