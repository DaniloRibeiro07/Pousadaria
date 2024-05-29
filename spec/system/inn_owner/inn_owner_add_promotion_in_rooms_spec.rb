require 'rails_helper'

describe "Inn Owner add promotion in rooms" do
  it 'adiciona promoção apenas a uma pousada' do 
    inn_owner = InnOwner.create!(first_name: 'Joao', last_name: 'Almeida',  document: '53783222001', email: 'joao@email.com', password: '123456')
    inn = inn_owner.create_inn!(name: 'Pousada do Almeidinha', registration_number: '30638898000199', description: 'Um bom lugar', 
                                address_attributes: { address: 'Rua X', number: '100', city: 'Manaus', state: 'AM', postal_code: '69067-080', neighborhood: 'Centro'})

    inn.inn_rooms.create!(name: 'Quarto com Varanda', size: 35, guest_limit: 3)
    inn.inn_rooms.create!(name: 'Quarto Térreo', size: 30, guest_limit: 3)

    login_as inn_owner, scope: :inn_owner

    visit root_path
    click_on "Gestão de Pousadas"
    click_on "Área de promoções"
    click_on "Adicionar Promoção"

    fill_in "Nome", with: "Promoção relâmpago"
    fill_in "Data de inicio", with: 1.day.from_now
    fill_in "Data fim", with: 2.day.from_now

    check "Quarto Térreo"

    click_on "Cadastrar Promoção"

    expect(current_path).to eq "link das promoçoes"
    expect(page).to have_content "Promoção relâmpago"
    expect(page).to have_content "Quarto Térreo"
    expect(page).not_to have_content "Quarto com Varanda"
  end
end