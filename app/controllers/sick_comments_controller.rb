class SickCommentsController < ApplicationController
  def create
    comment = SickComment.new
    comment.comment_by_user_id = current_user.id
    comment.sick_id = params[:sick_id]
    comment.contents = params[:sick_comment][:contents]

   if comment.save
      flash[:notice] = 'コメントしました or アドバイスしました'                                  
      head 201
    else
      render json: { messages: ticket.errors.full_messages }, status: 422                
    end
  end

end
