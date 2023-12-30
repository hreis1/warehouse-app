class Api::V1::WarehousesController < Api::V1::ApiController
  def show
    warehouse = Warehouse.find(params[:id])
    render status: 200, json: warehouse.as_json(except: [:created_at, :updated_at])
  end

  def index
    warehouses = Warehouse.all
    render status: 200, json: warehouses.as_json(except: [:created_at, :updated_at])
  end

  def create
    warehouse = Warehouse.new(params.require(:warehouse).permit(:name, :city, :code, :address, :description, :area, :cep))
    if warehouse.save
      render status: 201, json: warehouse.as_json(except: [:created_at, :updated_at])
    else
      render status: 412, json: {errors: warehouse.errors.full_messages}.as_json
    end
  end
end