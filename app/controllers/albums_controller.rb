class AlbumsController < ApplicationController

    def new
        if current_user
            flash[:band_id] = params[:band_id]
            render :new
        else
            redirect_to new_session_url
        end
    end

    def create
        @album = Album.new(album_params) #update to remove band_id from hidden input tag and use flash[:band_id]

        if @album.save
            redirect_to band_url(@album.band_id)
        else
            flash.now[:errors] = @album.errors.full_messages[0]
            render :new
        end
    end

    def edit
        if current_user
            @album = Album.find_by(id: params[:id])
            flash[:band_id] = params[:band_id]
            flash[:id] = params[:id]
            render :edit
        else
            redirect_to new_session_url
        end
    end

    def update
        @album = Album.find_by(id: flash[:id])

        if @album.update(album_params)
            redirect_to band_url(@album.band_id)
        else
            flash.now[:errors] = @album.errors.full_messages[0]
            render :edit
        end
    end

    def destroy
        @album = Album.find_by(id: params[:id])

        if current_user.id == @album.band.user_id
            @album.destroy
            redirect_to bands_url
        else
            redirect_to bands_url
        end

    end

    def show
        @album = Album.find_by(id: params[:id])

        if @album && current_user
            render :show
        else
            redirect_to bands_url
        end
    end

    private

    def album_params
        params.require(:album).permit(:title, :year, :live_album, :band_id)
    end

end
