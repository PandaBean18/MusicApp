class TracksController < ApplicationController
    def new
        if current_user
            flash[:album_id] = params[:album_id]
            render :new
        else
            redirect_to new_session_url
        end
    end

    def create
        new_track_params = tracks_params
        new_track_params[:album_id] = flash[:album_id]

        @track = Track.new(new_track_params)

        if @track.save
            redirect_to "/bands/#{@track.album.band.id}/albums/#{@track.album.id}/tracks/#{@track}"
        else
            flash[:album_id] = new_track_params[:album_id]
            flash.now[:errors] = @track.errors.full_messages[0]
            render :new
        end
    end

    def show
        @track = Track.find_by(id: params[:id])

        if @track && current_user
            render :show
        else
            redirect_to bands_url
        end
    end

    def edit
        @track = Track.find_by(id: params[:id])
        if current_user
            flash[:id] = params[:id]
            flash[:album_id] = params[:album_id]
            render :edit
        else
            redirect_to :bands_url
        end
    end

    def update
        @track = Track.find_by(id: flash[:id])

        if @track.update(tracks_params)
            redirect_to "/bands/#{@track.album.band.id}/albums/#{@track.album.id}/tracks/#{@track.id}"
        else
            flash[:id] = params[:id]
            flash[:album_id] = params[:album_id]
            render :edit
        end
    end

    private

    def tracks_params
        params.require(:track).permit(:title, :ord, :bonus_track, :lyrics)
    end
end
