class Api::V1::InnsController < ActionController::API
  def details 
    cnpj = params[:cnpj]
    if Inn.find_by(registration_number: cnpj)
      
    else
      render status: 406, json: {"errors": "Não há uma pousada com o CNPJ #{cnpj}"}
    end
  end
end