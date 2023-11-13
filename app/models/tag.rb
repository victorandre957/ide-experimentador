class Tag < ApplicationRecord
    has_many :trials, through: :classification
end
