require "rails_helper"

RSpec.describe "todos#destroy", type: :request do
  subject(:make_request) do
    jsonapi_delete "/api/v1/todos/#{todo.id}"
  end

  describe "basic destroy" do
    let!(:todo) { create(:todo) }

    it "updates the resource" do
      expect(TodoResource).to receive(:find).and_call_original
      expect do
        make_request
        expect(response.status).to eq(200), response.body
      end.to change { Todo.count }.by(-1)
      expect { todo.reload }.
        to raise_error(ActiveRecord::RecordNotFound)
      expect(json).to eq("meta" => {})
    end
  end
end
