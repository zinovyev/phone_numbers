module Api
  module V1
    class NumberPlanEntriesController < ApplicationController
      def index
        render json: resources
      end

      private

      def search_query
        params[:search]
      end

      def resources
        return [] unless search_query
        NumberPlanEntry.search(search_query)
      end
    end
  end
end
