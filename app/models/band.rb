class Band < ApplicationRecord
    validates :name, :user_id, presence: true

    belongs_to(
        :user,
        class_name: 'User',
        foreign_key: 'user_id',
        primary_key: 'id'
    )

    has_many(
        :albums,
        class_name: 'Album',
        foreign_key: 'band_id',
        primary_key: 'id',
        dependent: :destroy
    )

    has_many(:tracks, through: :albums)
end