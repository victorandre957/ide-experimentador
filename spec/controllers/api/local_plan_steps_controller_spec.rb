require 'rails_helper'

describe Api::LocalPlanStepsController, type: :controller do
  let(:robot) { Robot.create! }

  describe 'GET #index_by_robot' do
    it 'returns status OK' do
      perform_get_index
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST #create' do
    let(:valid_params) { { stepNumber: 10, label: 'teste', parameters: 'teste', skill: 'test', robot_id: robot.id } }

    it 'creates a local plan with valid params' do
      perform_create(valid_params)
      expect(response).to have_http_status(:created)
      expect(LocalPlanStep.count).to eq(1)
    end

    it 'returns status bad_request with invalid params' do
      perform_create(nil)
      expect(response).to have_http_status(:bad_request)
    end
  end

  describe 'DELETE #delete' do
    let(:local_plan_step) { create_local_plan_step }

    it 'deletes a local plan' do
      perform_delete(local_plan_step.id)
      expect(response).to have_http_status(:ok)
    end

    it 'returns error if local plan does not exist' do
      perform_delete(nil)
      expect(response).to have_http_status(:not_found)
    end
  end

  describe 'PATCH #update' do
    let(:local_plan_step) { create_local_plan_step }

    it 'updates a local plan and returns the updated label' do
      expect_update_to_have_response(local_plan_step.id, 'Novo Label', :ok)
      expect_updated_label(local_plan_step.id, 'Novo Label')
    end

    it 'returns error if local_plan_step does not exist' do
      expect_update_to_have_response(nil, 'Novo Label', :not_found)
    end

    it 'returns error if update fails' do
      expect_update_to_have_response(local_plan_step.id, 'Novo Label', :bad_request)
    end
  end

  private

  def perform_get_index
    get :index_by_robot
  end

  def perform_create(params)
    post :create, params: { local_plan_step: params }
  end

  def perform_delete(id)
    delete :delete, params: { id: id }
  end

  def perform_patch_update(id, params)
    patch :update, params: { id: id, local_plan_step: params }
  end

  def create_local_plan_step
    LocalPlanStep.create!(stepNumber: 1, label: 'Exemplo', parameters: 'Parâmetros', skill: 'test', robot_id: robot.id)
  end

  def expect_update_to_have_response(id, new_label, expected_status)
    perform_patch_update(id, { label: new_label })
    expect(response).to have_http_status(expected_status)
  end

  def expect_updated_label(id, new_label)
    return unless response.status == :ok

    expect(JSON.parse(response.body)['label']).to eq(new_label)
  end
end
