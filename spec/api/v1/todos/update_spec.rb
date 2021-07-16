require "rails_helper"

RSpec.describe "todos#update", type: :request do
  subject(:make_request) do
    jsonapi_put "/api/v1/todos/#{todo.id}", payload
  end

  describe "basic update" do
    let!(:todo) { create(:todo) }

    let(:payload) do
      {
        data: {
          id: todo.id.to_s,
          type: "todos",
          attributes: {
            # ... your attrs here
          },
        },
      }
    end

    # Replace 'xit' with 'it' after adding attributes
    xit "updates the resource" do
      expect(TodoResource).to receive(:find).and_call_original
      expect do
        make_request
        expect(response.status).to eq(200), response.body
      end.to change { todo.reload.attributes }
    end
  end
end
