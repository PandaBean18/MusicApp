class AddLyricsToTracks < ActiveRecord::Migration[6.1]
    def change
        add_column(:tracks, :lyrics, :text)
    end
end
