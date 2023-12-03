require 'rails_helper'

  
  describe HelloController ,type: :controller do
    describe "test" do
      it "return a Json" do
        get :index
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end
  
        