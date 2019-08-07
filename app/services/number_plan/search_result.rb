module NumberPlan
  SearchResult = Struct.new(:data, :count) do
    def to_json(context = nil)
      attributes.to_json
    end

    def attributes
      { data: data.map { |resource| NumberPlanEntrySerializer.new(resource).attributes }, count: count }
    end
  end
end
