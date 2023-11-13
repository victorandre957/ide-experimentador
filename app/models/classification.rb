class Classification < ApplicationRecord
    belongs_to :tag
    belongs_to :trial
end
