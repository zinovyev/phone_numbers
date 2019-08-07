module Api
  module V1
    class NumberPlanEntriesController < ApplicationController
      def index
        render json: resources
      end

      private

      def page
        page = params[:page].to_i
        (page && page > 0) ? page : 1
      end

      def search_query
        params[:search]
      end

      def resources
        @resources ||= begin
          return [] unless search_query
          NumberPlanEntry.search(search_query, page: page)
        end
      end
    end
  end
end
