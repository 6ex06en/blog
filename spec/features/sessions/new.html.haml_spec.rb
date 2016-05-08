require 'rails_helper'

RSpec.describe "Авторизация", type: "feature", js: true do
  let!(:user) {User.create(name: "test", password: "test",
                                        password_confirmation: "test")}

  describe "когда все поля заполнены верно" do

    before {
      visit signin_path
      fill_in           "Имя",    with: user.name
      fill_in           "Пароль", with: user.password
      click_button      "Войти"
    }

    it "должна отобразиться имя авторизованного пользователя" do
      expect(page).to have_content(user.name)
    end

    it "должна отрендериться главная страница" do
      expect(page).to have_selector(".articles__container")
    end
  end

  describe "когда поля c ошибками" do

    before {
      visit signin_path
      fill_in           "Имя",    with: user.name
      fill_in           "Пароль", with: "error"
      click_button      "Войти"
    }

    it "должно отобразиться flash сообщение" do
      expect(page).to have_content("Неверный пользователь или пароль")
    end

    it "не должно отражаться имя авторизованного пользователя" do
      expect(page).not_to have_content(user.name)
    end

    it "должна отрендериться страница входа" do
      expect(page).to have_content("Пароль")
      expect(page).to have_selector("input[type='submit'][value='Войти']")
    end

  end
end
