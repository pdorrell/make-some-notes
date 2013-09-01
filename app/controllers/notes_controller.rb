class NotesController < ApplicationController
  def new
    @note = Note.new
    @note.user = current_user
  end
  
  def index
    @notes = current_user ? current_user.notes : nil
  end
  
  def show
    @note = Note.find(params[:id])
  end
  
  def create
    creation_params = note_params
    creation_params[:user_id] = current_user.id
    @note = Note.create(creation_params)
    if @note.valid?
      flash[:notice] = "New note created"
      redirect_to note
    else
      flash[:error] = "Note not valid"
      render "new"
    end
  end
  
  def destroy
    @note = Note.find(params[:id])
    if @note.destroy
      flash[:notice] = "Note #{@note.title.inspect} was deleted";
      redirect_to root_path
    end
  end
    
  
  def note_params
    params.require(:note).permit(:title, :text)
  end
end
