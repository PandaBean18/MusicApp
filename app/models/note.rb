class Note < ApplicationRecord
    validates :note, :track_id, :user_id, presence: true 

    belongs_to(
        :user, 
        class_name: 'User', 
        foreign_key: 'user_id', 
        primary_key: 'id'
    )

    belongs_to(
        :track, 
        class_name: 'Track', 
        foreign_key: 'track_id', 
        primary_key: 'id'
    )
end
