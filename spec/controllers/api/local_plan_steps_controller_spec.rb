require 'rails_helper'

describe Api::LocalPlanStepsController, type: :controller do
    describe '/GET #index' do
        it 'return status OK' do
            get :index_by_robot, params: { robot_id: 'some_id' }
            expect(response).to have_http_status(:ok)
        end
    end
    describe '/GET #create' do
        let!(:robot) {Robot.create!()}
        let!(:local_plan_step_params) do
            {stepNumber:1, label:"navto_room", 
            parameter: {
              room: "PC Room 3",
              waypoints: [
                { x: -27.23, y: 18.0, z: -1.57 },
                { x: -27.23, y: 16.0 },
                { x: -28.5, y: 16.0 },
                { x: -28.5, y: 18.0, z: -1.57 }
              ]
            }, skill:"navigation", robot_id: robot.id}
        end
        context 'should create a plan with good params' do
            it 'return status created' do
                post :create, params: {local_plan_step: local_plan_step_params}
                    expect(response).to have_http_status(:created)
#                    expect { post :create, params: { local_plan_step: local_plan_step_params } }.to change(LocalPlanStep, :count).by(1)
            end
        end
        context 'should create a plan with bad params' do
            it 'return status bad_request' do
                local_plan_step_params[:stepNumber] = nil
                post :create , params: {local_plan_step: local_plan_step_params}
                expect(response).to have_http_status(:unprocessable_entity)
            end
        end
    end
    describe 'DELETE #delete' do
    let!(:robot) {Robot.create!()}
    let!(:local_plan_step) { LocalPlanStep.create!(stepNumber:1, label:"navto_room", 
    parameter: {
      room: "PC Room 3",
      waypoints: [
        { x: -27.23, y: 18.0, z: -1.57 },
        { x: -27.23, y: 16.0 },
        { x: -28.5, y: 16.0 },
        { x: -28.5, y: 18.0, z: -1.57 }
      ]
    }, skill:"navigation", robot_id: robot.id) }
    it 'delete a local plan' do
      delete :delete, params: { id: local_plan_step.id }
      expect(response).to have_http_status(:ok)
    end

    it 'return error if local plan dont exist' do
      delete :delete, params: { id: [-1] }
      expect(response).to have_http_status(:not_found)
    end
  end
  
  describe 'PATCH #update' do
    let!(:robot) {Robot.create!()}
    let!(:local_plan_step) { LocalPlanStep.create!(stepNumber: 1, label: 'Exemplo', parameters: 'Parâmetros', skill:"test", robot_id: robot.id) }

    it 'Update a local plan' do
      updated_params = { label: 'Novo Label' }

      patch :update, params: { id: local_plan_step.id, local_plan_steps: updated_params }

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['label']).to eq('Novo Label')
    end

    it 'return a error if local_plan_step dont exist' do
      patch :update, params: { id: nil , local_plan_steps: { label: 'Novo Label' } }

      expect(response).to have_http_status(:not_found)
    end

    it 'returns error if update fails' do
      allow_any_instance_of(LocalPlanStep).to receive(:update!).and_raise(ActiveRecord::RecordInvalid.new(LocalPlanStep.new))
      patch :update, params: { id: local_plan_step.id, local_plan_steps: { label: 'Novo Label' } }
      expect(response).to have_http_status(:bad_request)
    end
  end
end