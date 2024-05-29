require 'rails_helper'

describe 'request inn details' do
  it 'cnpj not found' do 
    get "link da requisicao da api da pousada"

    expect(response.status).to eq 406 
    expect(response.content_type).to include "json"
    json_response = JSON.parse(response.body)
    expect(json_response['errors']).to eq "Não há uma pousada com o CNPJ #{cnpj}"
  end
end