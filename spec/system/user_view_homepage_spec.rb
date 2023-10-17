require "rails_helper"

describe "User views homepage" do
  it "and sees a name of the app" do
    
    visit root_path

    expect(page).to have_content("Galpões & Estoque")
  end
end