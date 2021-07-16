require "rails_helper"

RSpec.describe TodoResource, type: :resource do
  describe "creating" do
    let(:payload) do
      {
        data: {
          type: "todos",
          attributes: {},
        },
      }
    end

    let(:instance) do
      TodoResource.build(payload)
    end

    it "works" do
      expect do
        expect(instance.save).to eq(true),
                                 instance.errors.full_messages.to_sentence
      end.to change { Todo.count }.by(1)
    end
  end

  describe "updating" do
    let!(:todo) { create(:todo) }

    let(:payload) do
      {
        data: {
          id: todo.id.to_s,
          type: "todos",
          attributes: {}, # Todo!
        },
      }
    end

    let(:instance) do
      TodoResource.find(payload)
    end

    xit "works (add some attributes and enable this spec)" do
      expect do
        expect(instance.update_attributes).to eq(true)
      end.to change { todo.reload.updated_at }
      # .and change { todo.foo }.to('bar') <- example
    end
  end

  describe "destroying" do
    let!(:todo) { create(:todo) }

    let(:instance) do
      TodoResource.find(id: todo.id)
    end

    it "works" do
      expect do
        expect(instance.destroy).to eq(true)
      end.to change { Todo.count }.by(-1)
    end
  end
end
