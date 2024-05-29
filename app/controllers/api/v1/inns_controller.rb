class Api::V1::InnsController < ActionController::API
  def details 
    cnpj = params[:cnpj]
    inn = Inn.find_by(registration_number: cnpj)
    if inn
      render status: 200, json: inn.as_json(only: [:name, :description, :registration_number], 
                                methods: :full_address).merge({number_of_rooms: inn.inn_rooms.count})
    else
      render status: 406, json: {"errors": "Não há uma pousada com o CNPJ #{cnpj}"}
    end
  end
end