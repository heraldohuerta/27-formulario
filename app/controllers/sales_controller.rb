class SalesController < ApplicationController
  def new
    @sale = Sale.new
  end

  def done
     @sales = Sale.all
  end

  def create
      sale       = Sale.new
      value      = params[:sale][:value].to_i
      discount   = params[:sale][:discount].to_i
      exento_iva =  ( params[:sale][:iva] == "1" )
      #SE APLICA DESCUENTO
      total = value * ( 1 - ( discount / 100.0 ))
      #SE VALIDA IVA
      if !exento_iva
        sale.tax = 19
        total *= 1.19
      else
        sale.tax = 0
      end

      sale.detail     = params[:sale][:detail]
      sale.discount   = params[:sale][:discount]
      sale.value      = value
      sale.total      = total
      sale.category   = params[:sale][:category]
      sale.cod        = DateTime.now.to_i

      if sale.save
         redirect_to done_path, notice: 'Venta fue almacenada.'
      else
       redirect_to sales_new_path, notice:   'No se registro la Venta'
      end
    end
end
