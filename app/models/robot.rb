class Robot < ApplicationRecord
    has_many :local_plan_steps, dependent: :destroy
end
