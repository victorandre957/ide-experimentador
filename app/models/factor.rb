class Factor < ApplicationRecord
    has_many :trials, through: :trial_factor
end
