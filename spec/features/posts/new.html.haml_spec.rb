require 'rails_helper'

RSpec.describe "Создание поста.", type: "feature", js: true do

  let!(:user) {User.create(name: "test", password: "test",
                                        password_confirmation: "test")}

  before { sign_in user, capybara: true}

  describe "Когда успешно создан" do

    before do
      visit new_user_post_path(user)
      fill_in      "Название",    with: "имя_поста"
      fill_in      "Содержимое",  with: "контент_поста"
      attach_file  "Изображение", "#{Rails.root}/vendor/assets/images/for_test/_1.jpg"
      click_button "Создать"
    end

    it "должна отрендериться главная страница" do
      expect(page).to have_selector ".articles__container"
    end

    it "должно появиться flash сообщение" do
      expect(page).to have_content "Пост создан"
    end

    it "пост должен отразиться на странице" do
      expect(page).to have_content "имя_поста"
      expect(page).to have_link    "имя_поста"
    end

  end

  describe "Когда создать не удалось" do

    before do
      visit new_user_post_path(user)
      click_button "Создать"
    end

    it "должна отрендериться страница создания поста" do
      expect(page).to have_selector("input[type='submit'][value='Создать']")
      expect(page).to have_content("Содержимое")
    end

    it "должны появиться сообщения с описанием ошибки" do
      expect(page).to have_css(".alert-danger", count: 3)
      expect(page).to have_content("can't be blank")
    end

    it "на главной странице не должно быть поста" do
      visit root_path
      expect(page).not_to have_content "имя_поста"
    end

  end
end
