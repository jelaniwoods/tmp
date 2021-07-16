require "rails_helper"

RSpec.describe TodoResource, type: :resource do
  describe "serialization" do
    let!(:todo) { create(:todo) }

    it "works" do
      render
      data = jsonapi_data[0]
      expect(data.id).to eq(todo.id)
      expect(data.jsonapi_type).to eq("todos")
    end
  end

  describe "filtering" do
    let!(:todo1) { create(:todo) }
    let!(:todo2) { create(:todo) }

    context "by id" do
      before do
        params[:filter] = { id: { eq: todo2.id } }
      end

      it "works" do
        render
        expect(d.map(&:id)).to eq([todo2.id])
      end
    end
  end

  describe "sorting" do
    describe "by id" do
      let!(:todo1) { create(:todo) }
      let!(:todo2) { create(:todo) }

      context "when ascending" do
        before do
          params[:sort] = "id"
        end

        it "works" do
          render
          expect(d.map(&:id)).to eq([
                                      todo1.id,
                                      todo2.id,
                                    ])
        end
      end

      context "when descending" do
        before do
          params[:sort] = "-id"
        end

        it "works" do
          render
          expect(d.map(&:id)).to eq([
                                      todo2.id,
                                      todo1.id,
                                    ])
        end
      end
    end
  end

  describe "sideloading" do
    # ... your tests ...
  end
end
