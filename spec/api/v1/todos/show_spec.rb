require "rails_helper"

RSpec.describe "todos#show", type: :request do
  let(:params) { {} }

  subject(:make_request) do
    jsonapi_get "/api/v1/todos/#{todo.id}", params: params
  end

  describe "basic fetch" do
    let!(:todo) { create(:todo) }

    it "works" do
      expect(TodoResource).to receive(:find).and_call_original
      make_request
      expect(response.status).to eq(200)
      expect(d.jsonapi_type).to eq("todos")
      expect(d.id).to eq(todo.id)
    end
  end
end
