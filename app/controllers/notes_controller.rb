class NotesController < ApplicationController
    def create

        if current_user
            @note = Note.new(user_id: current_user.id, track_id: note_params[:track_id], note: note_params[:note])
            if @note.save
                redirect_to "/bands/#{@note.track.album.band.id}/albums/#{@note.track.album.id}/tracks/#{@note.track.id}"
            else
                flash.now[:errors] = @note.errors.full_messages[0]
                render "/bands/#{@note.track.album.band.id}/albums/#{@note.track.album.id}/tracks/#{@note.track.id}"
            end
        else
            redirect_to bands_url
        end
    end

    def destroy
        @note = Note.find_by(id: note_params[:id])
        redirect_url = "/bands/#{@note.track.album.band.id}/albums/#{@note.track.album.id}/tracks/#{@note.track.id}"
        @note.destroy

        redirect_to redirect_url
    end

    private

    def note_params
        params.require(:note).permit(:track_id, :note, :id)
    end
end
