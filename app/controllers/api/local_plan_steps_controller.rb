# controllers/api/local_plan_steps_controller.rb
#
# Controller responsible for handling API endpoints related to local plan steps.

class Api::LocalPlanStepsController < ApplicationController
  # Skips the authenticity token verification for API requests.
  skip_before_action :verify_authenticity_token

  # Includes modules containing index-related actions, step actions, and private methods.
  include LocalPlanStepsIndex
  include LocalPlanStepsActions
  include LocalPlanStepsPrivate
end
