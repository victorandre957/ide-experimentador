class Trial < ApplicationRecord
    has_many :factors, through: :trial_factor
    has_many :trial_executions
    has_many :tags, through: :classification
    belongs_to :experiment
end
