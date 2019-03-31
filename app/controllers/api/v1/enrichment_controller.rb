class API::V1::EnrichmentController< ApplicationController
  # TODO: Remove once we integrate
  skip_forgery_protection

  def enrich_activities
    # TODO: Protect the Params
    #params.permit(:results).permit(:actor, :category_slug, :slug, :foreign_id, :id, :object, :origin, :slug, :target, :time, :verb)
    results = params.to_unsafe_h['results']
    enricher = StreamRails::Enrich.new

    @activities = enricher.enrich_activities(results)
    @categories = Category.all

    respond_to do |format|
      format.js { render layout: false }
    end
  end
end