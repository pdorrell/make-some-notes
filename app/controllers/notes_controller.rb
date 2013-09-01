class NotesController < ApplicationController
  def new
    @note = Note.new
    @note.user = current_user
  end
  
  def show
    @note = Note.find(params[:id])
  end
  
  def create
    creation_params = note_params
    puts "creation_params = #{creation_params.inspect}"
    creation_params[:user_id] = current_user.id
    note = Note.create(creation_params)
    if note
      redirect_to note
    end
  end
  
  def destroy
    @note = Note.find(params[:id])
    if @note.destroy
      flash.notice("Note #{@note.title.inspect} was deleted");
      redirect_to root_path
    end
  end
    
  
  def note_params
    params.require(:note).permit(:title, :text)
  end
end
