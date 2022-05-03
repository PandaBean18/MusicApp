class BandsController < ApplicationController
    def new
        @band = Band.new
        if current_user
            render :new
        else
            redirect_to new_session_url
        end
    end

    def create
        band_name = params[:band][:name]
        user_id = current_user.id
        @band = Band.new(name: band_name, user_id:  user_id)

        if @band.save
            redirect_to bands_url
        else
            flash.now[:errors] = @band.errors.full_messages[0]
            render :new
        end

    end

    def show
        if current_user
            @band = Band.find_by(id: params[:id])
            if @band
                render :show
            else
                redirect_to bands_url
            end
        else  
            redirect_to new_session_url
        end
    end

    def edit
      @band = Band.find_by(id: params[:id])
      if @band.id == current_user.id
        render :edit
      else
        band_url(@band)
      end
    end

    def update
      @band = Band.find_by(id: params[:band][:id])
      if @band.update(name: params[:band][:name])
        redirect_to band_url(@band)
      else
        flash.now[:errors] = @band.errors.full_messages[0]
        render :edit
      end
    end

    def destroy
      id = params[:id]
      band = Band.find_by(id: id)
      if band
        band.destroy
      end
      redirect_to bands_url
    end
end
