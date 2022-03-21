class TenantsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :render_with_unprocessable_entity
    
        def index
            tenants = Tenant.all
            render json: tenants
        end
    
        def show
            tenant = find_tenants
            render json: tenant
        end
    
        def create
            tenant = Tenant.create!(tenant_params)
            render json: tenant
        end
    
        def destroy
            tenant = find_tenants
            tenant.destroy!
            head :no_content
        end
    
        def update
            tenant = find_tenants
            tenant = Tenant.update(tenants_params)
            render json: tenant
        end
    
        private
    
        def find_tenants
           Tenant.find(params[:id])
        end
    
        def tenant_params
            Tenant.permit(:age, :name)
        end
    
        def render_not_found_response
            render json: {error: "Tenant not found"}, status: :not_found
        end
    
        def render_with_unprocessable_entity
            render json: { errors: invalid.record.errors.full.messages }, status: :unprocessable_entity
        end
    
    
end