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
            { local_plan:[{stepNumber:1, label:"navto_room", 
            parameter: {
              room: "PC Room 3",
              waypoints: [
                { x: -27.23, y: 18.0, z: -1.57 },
                { x: -27.23, y: 16.0, z: -1.50 },
                { x: -28.5, y: 16.0, z: -1.50 },
                { x: -28.5, y: 18.0, z: -1.57 }
              ]
            }, skill:"navigation"}], robot_Id: robot.id}
        end
        context 'should create a plan with good params(skill: navigation)' do
            it 'return status created' do
                post :create, params:  local_plan_step_params
                p ("aquiiiiiiiiiiiiiiii")
                p(response)
                expect(response).to have_http_status(:created)
            end
        end
        context 'should create a plan with good params(skill: approach_robot)' do
          it 'return status created' do
            local_plan_step_params[:skill] = "approach_robot"
            local_plan_step_params[:label] = "approach_arm"
            local_plan_step_params[:parameter] = {topic: "lab_arm"}
            post :create, params: local_plan_step_params
              expect(response).to have_http_status(:created)
                
          end
      end
        context 'should create a plan with good params(authentication_person)' do
          it 'return status created' do
            local_plan_step_params[:skill] = "authenticate_person"
            local_plan_step_params[:label] = "authenticate_nurse"
            local_plan_step_params[:parameter] = {topic: "nurse"}
            post :create, params: local_plan_step_params
              expect(response).to have_http_status(:created)
                
          end
      end
        context 'should create a plan with good params(approuch_person)' do
          it 'return status created' do
            local_plan_step_params[:skill] = "approach_person"
            local_plan_step_params[:label] = "approach_nurse"
            local_plan_step_params[:parameter] = {topic: "nurse"}
            post :create, params: local_plan_step_params
              expect(response).to have_http_status(:created)
                
          end
      end
        context 'should create a plan with good params(wait_message)' do
          it 'return status created' do
            local_plan_step_params[:skill] = "wait_message"
            local_plan_step_params[:label] = "wait_nurse_to_complete_deposit"
            local_plan_step_params[:parameter] = {topic: "nurse"}
            post :create, params: local_plan_step_params
              expect(response).to have_http_status(:created)
                
          end
      end
        context 'should create a plan with good params(send_message)' do
          it 'return status created' do
            local_plan_step_params[:skill] = "send_message"
            local_plan_step_params[:label] = "notify_lab_arm_of_open_drawer_lab_completed"
            local_plan_step_params[:parameter] = {topic: "nurse"}
            post :create, params: {local_plan_step: local_plan_step_params}
              expect(response).to have_http_status(:created)
                
          end
      end
        context 'should create a plan with good params(operate_drawer)' do
          it 'return status created' do
            local_plan_step_params[:skill] = "operate_drawer"
            local_plan_step_params[:label] = "open_drawer_for_nurse"
            local_plan_step_params[:parameter] = {action: "open"}
            post :create, params: {local_plan_step: local_plan_step_params}
              expect(response).to have_http_status(:created)

                
          end
      end
        context 'should create a plan with good params(operate_drawer)' do
          it 'return status created' do
            local_plan_step_params[:skill] = "operate_drawer"
            local_plan_step_params[:label] = "close_drawer_for_nurse"
            local_plan_step_params[:parameter] = {action: "close"}
            post :create, params: {local_plan_step: local_plan_step_params}
              expect(response).to have_http_status(:created)
                
          end
      end
      
        context 'should create a plan with invalid stepNumeber' do
          it 'return status unprocessable_entity' do
              local_plan_step_params[:stepNumber] = "non numeric"
                post :create , params: {local_plan_step: local_plan_step_params}
                    expect(response).to have_http_status(:unprocessable_entity)
            end
        end
        context 'should create a plan with invalid label' do
            it 'return status unprocessable_entity' do
              local_plan_step_params[:label] = nil
              post :create , params: {local_plan_step: local_plan_step_params}
                expect(response).to have_http_status(:unprocessable_entity)
            end
        end
        context 'should create a plan with invalid robot' do
          it 'return status unprocessable_entity' do
            local_plan_step_params[:robot_id] = [-1]
            post :create , params: {local_plan_step: local_plan_step_params}
            expect(response).to have_http_status(:unprocessable_entity)
          end
      end
        context 'should create a plan with invalid skill' do
          it 'return status unprocessable_entity' do
            local_plan_step_params[:skill] = "invalid skill"
            post :create , params: {local_plan_step: local_plan_step_params}
            expect(response).to have_http_status(:unprocessable_entity)
          end
      end
      #The next creat tests related to the parameters are using skill: operate_drawer
        context 'should create a plan with invalid parameter name' do
          it 'return status unprocessable_entity' do
            local_plan_step_params[:parameter] = {invalid: "open"}
            post :create , params: {local_plan_step: local_plan_step_params}
            expect(response).to have_http_status(:unprocessable_entity)
        end
      end
        context 'should create a plan with invalid parameter(size)' do
          it 'return status unprocessable_entity' do
            local_plan_step_params[:parameter] = {action:"open", invalid:"open"}
            post :create , params: {local_plan_step: local_plan_step_params}
            expect(response).to have_http_status(:unprocessable_entity)
          end
      end
        context 'should create a plan with invalid parameter(action)' do
          it 'return status unprocessable_entity' do
            local_plan_step_params[:parameter] = {action: "invalid"}
            post :create , params: {local_plan_step: local_plan_step_params}
            expect(response).to have_http_status(:unprocessable_entity)
        end
      end
        #The next creat tests related to the parameters are using skill: navigation
        context 'should create a plan with invalid parameter name' do
          it 'return status unprocessable_entity' do
            local_plan_step_params[:parameter] = {invalid: "PC room 3", invalid: [
              { x: -27.23, y: 18.0, z: -1.57 },
              { x: -27.23, y: 16.0, z: -1.50 },
              { x: -28.5, y: 16.0, z: -1.50 },
              { x: -28.5, y: 18.0, z: -1.57 }]}
            post :create , params: {local_plan_step: local_plan_step_params}
            expect(response).to have_http_status(:unprocessable_entity)
        end
      end
        context 'should create a plan with invalid parameter(size)' do
          it 'return status unprocessable_entity' do
            local_plan_step_params[:parameter] = {room:"invalid room"}
            post :create , params: {local_plan_step: local_plan_step_params}
            expect(response).to have_http_status(:unprocessable_entity)
          end
      end
        context 'should create a plan with invalid parameter(waypoints)' do
          it 'return status unprocessable_entity' do
            local_plan_step_params[:parameter] = {room: "PC room 3", waypoints: [
              { x: -27.23, y: 18.0, z: -1.57 },
              { x: -27.23, y: 16.0 },
              { x: -28.5, y: 16.0 },]}
            post :create , params: {local_plan_step: local_plan_step_params}
            expect(response).to have_http_status(:unprocessable_entity)
        end
      end
        #The next creat tests related to the parameters are using skill: approach_robot
        context 'should create a plan with invalid parameter name' do
          it 'return status unprocessable_entity' do
            local_plan_step_params[:parameter] = {invalid: "lab_arm"}
            post :create , params: {local_plan_step: local_plan_step_params}
            expect(response).to have_http_status(:unprocessable_entity)
        end
      end
        context 'should create a plan with invalid parameter(size)' do
          it 'return status unprocessable_entity' do
            local_plan_step_params[:parameter] = {topic:"lab_arm", invalid:"test"}
            post :create , params: {local_plan_step: local_plan_step_params}
            expect(response).to have_http_status(:unprocessable_entity)
          end
      end
        #The next creat tests related to the parameters are using skill: authenticate_person
        context 'should create a plan with invalid parameter name' do
          it 'return status unprocessable_entity' do
            local_plan_step_params[:parameter] = {topic: "nurse"}
            post :create , params: {local_plan_step: local_plan_step_params}
            expect(response).to have_http_status(:unprocessable_entity)
        end
      end
        context 'should create a plan with invalid parameter(size)' do
          it 'return status unprocessable_entity' do
            local_plan_step_params[:parameter] = {topic:"nurse", invalid:"test"}
            post :create , params: {local_plan_step: local_plan_step_params}
            expect(response).to have_http_status(:unprocessable_entity)
          end
      end
        #The next creat tests related to the parameters are using skill: approach_person
        context 'should create a plan with invalid parameter name' do
          it 'return status unprocessable_entity' do
            local_plan_step_params[:parameter] = {topic: "nurse"}
            post :create , params: {local_plan_step: local_plan_step_params}
            expect(response).to have_http_status(:unprocessable_entity)
        end
      end
        context 'should create a plan with invalid parameter(size)' do
          it 'return status unprocessable_entity' do
            local_plan_step_params[:parameter] = {topic:"nurse", invalid:"test"}
            post :create , params: {local_plan_step: local_plan_step_params}
            expect(response).to have_http_status(:unprocessable_entity)
          end
      end
        #The next creat tests related to the parameters are using skill: wait_message
        context 'should create a plan with invalid parameter name' do
          it 'return status unprocessable_entity' do
            local_plan_step_params[:parameter] = {topic: "nurse"}
            post :create , params: {local_plan_step: local_plan_step_params}
            expect(response).to have_http_status(:unprocessable_entity)
        end
      end
        context 'should create a plan with invalid parameter(size)' do
          it 'return status unprocessable_entity' do
            local_plan_step_params[:parameter] = {topic:"nurse", invalid:"test"}
            post :create , params: {local_plan_step: local_plan_step_params}
            expect(response).to have_http_status(:unprocessable_entity)
          end
      end
        #The next creat tests related to the parameters are using skill: send_message
        context 'should create a plan with invalid parameter name' do
          it 'return status unprocessable_entity' do
            local_plan_step_params[:parameter] = {topic: "nurse"}
            post :create , params: {local_plan_step: local_plan_step_params}
            expect(response).to have_http_status(:unprocessable_entity)
        end
      end
        context 'should create a plan with invalid parameter(size)' do
          it 'return status unprocessable_entity' do
            local_plan_step_params[:parameter] = {topic:"nurse", invalid:"test"}
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
        { x: -27.23, y: 16.0, z: -1.50 },
        { x: -28.5, y: 16.0, z: -1.50 },
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
    let!(:local_plan_step) { LocalPlanStep.create!(stepNumber:1, label:"navto_room", 
    parameter: {
      room: "PC Room 3",
      waypoints: [
        { x: -27.23, y: 18.0, z: -1.57 },
        { x: -27.23, y: 16.0, z: -1.50 },
        { x: -28.5, y: 16.0, z: -1.50 },
        { x: -28.5, y: 18.0, z: -1.57 }
      ]
    }, skill:"navigation", robot_id: robot.id) }

    it 'Update a local plan' do
      updated_params = { label: 'New Label' }
      patch :update, params: { id: local_plan_step.id, local_plan_step: updated_params }
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['label']).to eq('New Label')
    end

    it 'return a error if local_plan_step dont exist' do
      patch :update, params: { id: [-1] , local_plan_step: { label: 'New Label' } }
      expect(response).to have_http_status(:not_found)
    end

    it 'returns error if update fails' do
      allow_any_instance_of(LocalPlanStep).to receive(:update!).and_raise(ActiveRecord::RecordInvalid.new(LocalPlanStep.new))
      patch :update, params: { id: local_plan_step.id, local_plan_step: { label: 'New Label' } }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end