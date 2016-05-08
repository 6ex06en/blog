require 'rails_helper'

RSpec.describe "Редактирование поста.", type: "feature", js: true do

  let!(:owner)           { User.create(name: "test", password: "test",
                                       password_confirmation: "test") }
  let!(:other_user)      { User.create(name: "test1", password: "test1",
                                       password_confirmation: "test1") }
  let(:image_path)      { "#{Rails.root}/vendor/assets/images/for_test/_1.jpg" }
  let!(:post)           { owner.posts.create(name: "имя_поста",
                                             content: "контент_поста",
                                             picture: File.open(image_path) )}


  describe "Когда авторизовался собственник поста." do

    before do
      sign_in owner, capybara: true
      click_link "редактировать"
    end

    describe "Когда пост отредактирован" do

      before do
        fill_in "Название",   with: "имя_поста"
        fill_in "Содержимое", with: "измененный_контент_поста"
        click_button "Редактировать"
      end

      it "должна отрендериться страница редактирования поста" do
        expect(page).to have_selector("input[type='submit'][value='Редактировать']")
      end
      it "должно появиться flash сообщение" do
        expect(page).to have_content "Пост обновлен"
      end
      it "содержание поста должно измениться" do
        expect(page).to have_content     "измененный_контент_поста"
        expect(page).not_to have_content "имя_поста"
      end
    end

    describe "Когда пост отредактировать не удалось" do

      let(:unchangeble_post_name) { post.name }

      before do
        fill_in "Название",   with: ""
        fill_in "Содержимое", with: "измененный_контент_поста"
        click_button "Редактировать"
      end

      it "должна отрендериться страница редактирования поста" do
        expect(page).to have_selector("input[type='submit'][value='Редактировать']")
      end
      it "должно появиться сообщение об ошибке" do
        expect(page).to have_css      ".alert-danger"
        expect(page).to have_content  "can't be blank"
      end
      it "имя поста не должно измениться" do
        expect(page).to have_content "измененный_контент_поста"
        expect(post.name).to eq       unchangeble_post_name
      end
    end
  end

  describe "Не авторизованный пользователь" do

    describe "не сможет зайти на страницу редактирования поста" do
      before { visit edit_user_post_path(owner, post) }

      it "должен увидеть flash сообщение" do
        expect(page).to have_content "Вы не авторизовались"
      end

      it "должен быть переадресован на root" do
        expect(page).to have_selector ".articles__container"
      end
    end
  end

  describe "Не собственник поста пользователь" do

    before do
      sign_in other_user, capybara: true
    end

    describe "не сможет зайти на страницу редактирования чужого поста" do
      before { visit edit_user_post_path(owner, post) }

      it "должен быть переадресован на root" do
        expect(page).to have_selector ".articles__container"
      end
    end
  end

end
