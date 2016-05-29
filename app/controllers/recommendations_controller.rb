class RecommendationsController
  def show
    @products = Where(id: params[:ids])
    @recommended_by = params[:recommended_by]

    render nothing: true, if @products.none?
  end
end
