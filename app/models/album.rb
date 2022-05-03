class Album < ApplicationRecord
    validates :title, :year, :band_id, presence: true 
    validates :live_album, inclusion: { in: [true, false] }

    belongs_to(
        :band, 
        class_name: 'Band', 
        foreign_key: 'band_id',
        primary_key: 'id'
    )
    
    has_many(
        :tracks, 
        class_name: 'Track', 
        foreign_key: 'album_id', 
        primary_key: 'id',
        dependent: :destroy
    )
end
