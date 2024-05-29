require 'rails_helper'

describe 'request inn details' do
  context '/api/v1/inns/:cnpj' do
    it 'cnpj not found' do 
      cnpj = 999999
      get api_v1_inn_details_path(cnpj)

      expect(response.status).to eq 406 
      expect(response.content_type).to include "json"
      json_response = JSON.parse(response.body)
      expect(json_response['errors']).to eq "Não há uma pousada com o CNPJ #{cnpj}"
    end

    it 'sucess' do 
      inn_owner = InnOwner.create!(first_name: 'Joao', last_name: 'Almeida',  document: '53783222001', email: 'joao@email.com', password: '123456')
      inn = inn_owner.create_inn!(name: 'Pousada do Almeidinha', registration_number: '30638898000199', description: 'Um bom lugar', 
                                  address_attributes: { address: 'Rua X', number: '100', city: 'Manaus', state: 'AM', postal_code: '69067-080', neighborhood: 'Centro'})
  
      inn.inn_rooms.create!(name: 'Quarto com Varanda', size: 35, guest_limit: 3)
      inn.inn_rooms.create!(name: 'Quarto Térreo', size: 30, guest_limit: 3)

      get api_v1_inn_details_path(inn.registration_number)

      expect(response.status).to eq 200 
      expect(response.content_type).to include "json"
      json_response = JSON.parse(response.body)

      expect(json_response['name']).to eq "Pousada do Almeidinha"
      expect(json_response['registration_number']).to eq "30638898000199"
      expect(json_response['description']).to eq "Um bom lugar"
      expect(json_response['full_address']).to eq "Rua X, 100 - Centro - Manaus/AM"
      expect(json_response['number_of_rooms']).to eq 2
    end

    it 'E ocorre uma falha interna do servidor' do 
      allow(Inn).to receive(:find_by).and_raise(ActiveRecord::ActiveRecordError)
      get api_v1_inn_details_path(9999999)
      
      expect(response.status).to eq 500
    end
  end
end