require "rails_helper"

RSpec.describe "todos#index", type: :request do
  let(:params) { {} }

  subject(:make_request) do
    jsonapi_get "/api/v1/todos", params: params
  end

  describe "basic fetch" do
    let!(:todo1) { create(:todo) }
    let!(:todo2) { create(:todo) }

    it "works" do
      expect(TodoResource).to receive(:all).and_call_original
      make_request
      expect(response.status).to eq(200), response.body
      expect(d.map(&:jsonapi_type).uniq).to match_array(["todos"])
      expect(d.map(&:id)).to match_array([todo1.id, todo2.id])
    end
  end
end
