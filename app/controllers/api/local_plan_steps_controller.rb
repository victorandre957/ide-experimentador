# controllers/api/local_plan_steps_controller.rb
class Api::LocalPlanStepsController < ApplicationController
  skip_before_action :verify_authenticity_token

  include LocalPlanStepsIndex
  include LocalPlanStepsActions
  include LocalPlanStepsPrivate

end
