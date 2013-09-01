class NotesController < ApplicationController
  def new
    @note = Note.new
    @note.user = current_user
  end
  
  def edit
    @note = get_current_users_note(params[:id])
  end
  
  def index
    @notes = current_user ? current_user.notes : nil
  end
  
  def show
    @note = get_current_users_note(params[:id])
  end
  
  def create
    creation_params = note_params
    creation_params[:user_id] = current_user.id
    @note = Note.create(creation_params)
    if @note.valid?
      flash[:notice] = "New note created"
      redirect_to @note
    else
      render "new"
    end
  end
  
  def update
    update_params = note_params
    @note = get_current_users_note(params[:id])
    @note.update(update_params)
    if @note.valid?
      flash[:notice] = "Note updated"
      redirect_to @note
    else
      render "edit"
    end
  end
  
  def destroy
    @note = get_current_users_note(params[:id])
    if @note.destroy
      flash[:notice] = "Note #{@note.title.inspect} was deleted";
      redirect_to root_path
    end
  end
  
  private
  
  def note_params
    params.require(:note).permit(:title, :text)
  end
  
  def get_current_users_note(id)
    if !current_user
      raise ActiveRecord::RecordNotFound
    else
      current_user.notes.find(id)
    end
  end
end
