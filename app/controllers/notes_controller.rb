class NotesController < ApplicationController
  
  before_action :authorise_update, except: [:show]
  before_action :authorise_read, only: [:show]

  # Page to create a new note
  def new
    @note = Note.new
    @note.user = current_user
  end
  
  # Page to edit an existing note
  def edit
    @note = get_current_users_note(params[:id])
  end
  
  # Page to display a note.
  def show
    @note = get_current_users_note(params[:id])
  end
  
  # Action to create a new note
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
  
  # Action to update a note being edited
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
  
  # Action to delete a note
  def destroy
    @note = get_current_users_note(params[:id])
    if @note.destroy
      flash[:notice] = "Note #{@note.title.inspect} was deleted";
      redirect_to root_path
    end
  end
  
  private
  
  # Check CanCan authorisation for reading a note
  def authorise_read
    authorize! :read, Note
  end
  
  # Check CanCan authorisation for create/update/delete a note.
  def authorise_update
    authorize! :update, Note
  end

  # Strong parameters for creating/updating a note
  def note_params
    params.require(:note).permit(:title, :text)
  end
  
  # Get a note by id, _if_ it belongs to the current user.
  def get_current_users_note(id)
    if !current_user
      raise ActiveRecord::RecordNotFound
    else
      current_user.notes.find(id)
    end
  end
end
