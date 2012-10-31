class EnterprisesController < BaseController
  def index
    @enterprises = Enterprise.all
  end

  def suppliers
    @suppliers = Enterprise.is_supplier
  end

  def show
    options = {:enterprise_id => params[:id]}
    options.merge(params.reject { |k,v| k == :id })

    @enterprise = Enterprise.find params[:id]

    @searcher = Spree::Config.searcher_class.new(options)
    @products = @searcher.retrieve_products
  end

  def select_distributor
    distributor = Enterprise.is_distributor.find params[:id]

    order = current_order(true)

    if order.can_change_distributor?
      order.distributor = distributor
      order.save!
    end

    redirect_to distributor
  end

  def deselect_distributor
    order = current_order(true)

    if order.can_change_distributor?
      order.distributor = nil
      order.save!
    end

    redirect_to root_path
  end
end