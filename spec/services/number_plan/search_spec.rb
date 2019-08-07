require "rails_helper"
require "pry"

RSpec.describe NumberPlan::Search do
  let!(:entry1) { NumberPlanEntry.create(prefix: 123123, comment: "Bad Godesberg") }
  let!(:entry2) { NumberPlanEntry.create(prefix: 321321, comment: "Berlin") }

  let(:query1) { '12312312' }
  let(:query2) { '4912312312' }
  let(:query3) { '123-123-12' }
  let(:query4) { '123123 Berl' }

  describe "#call" do
    context "query with one numeric term" do
      it "is has a size of 1" do
        result = described_class.new(NumberPlanEntry, query1).call
        expect(result.data.count).to eq(1)
      end

      it "contains only Bad Godesberg" do
        result = described_class.new(NumberPlanEntry, query1).call
        expect(result.data.map(&:comment)).to eq(["Bad Godesberg"])
      end
    end

    context "query with one numeric term and prefix" do
      it "is has a size of 1" do
        result = described_class.new(NumberPlanEntry, query2).call
        expect(result.data.count).to eq(1)
      end

      it "contains only Bad Godesberg" do
        result = described_class.new(NumberPlanEntry, query2).call
        expect(result.data.map(&:comment)).to eq(["Bad Godesberg"])
      end
    end

    context "query with one numeric term devided by dashes" do
      it "is has a size of 1" do
        result = described_class.new(NumberPlanEntry, query3).call
        expect(result.data.count).to eq(1)
      end

      it "contains only Bad Godesberg" do
        result = described_class.new(NumberPlanEntry, query3).call
        expect(result.data.map(&:comment)).to eq(["Bad Godesberg"])
      end
    end

    context "query with one numeric and one textual term" do
      it "is has a size of 2" do
        result = described_class.new(NumberPlanEntry, query4).call
        expect(result.data.count).to eq(2)
      end

      it "contains both cities: Berlin and Bad Godesberg" do
        result = described_class.new(NumberPlanEntry, query4).call
        expect(result.data.map(&:comment).sort).to eq(["Bad Godesberg", "Berlin"])
      end
    end
  end
end
