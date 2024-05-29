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

  end
end