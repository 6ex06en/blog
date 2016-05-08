require 'rails_helper'

RSpec.describe "Удаление поста.", type: "feature", js: true do

  let!(:owner)           { User.create(name: "test", password: "test",
                                       password_confirmation: "test") }
  let!(:other_user)      { User.create(name: "test1", password: "test1",
                                       password_confirmation: "test1") }
  let(:image_path)      { "#{Rails.root}/vendor/assets/images/for_test/_1.jpg" }
  let!(:post)           { owner.posts.create(name: "имя_поста",
                                             content: "контент_поста",
                                             picture: File.open(image_path) )}

  describe "Когда авторизовался собственник поста" do

    before { sign_in owner, capybara: true }

    describe "после удаления статьи" do

      before { click_link "удалить" }

      it "должен быть редирект на главную страницу" do
        expect(page).to have_selector ".articles__container"
      end

      it "пост не должен отображаться" do
        visit root_path
        expect(page).not_to have_content post.name
      end

      it "пост должен быть удален из БД" do
        expect(Post.all).not_to include post
      end

    end

  end

  describe "Когда авторизовался другой пользователь" do

    before { sign_in other_user, capybara: true }

    describe "при попытке удаления поста" do

      before { destroy_post_path(owner, post) }

      it "должен быть редирект на главную странцу" do
        expect(page).to have_selector ".articles__container"
      end

      it "пост не должен быть удален" do
        expect(Post.all).to include post
      end
    end
  end

  describe "Неавторизованный пользователь" do

    describe "при попытке удаления поста" do

      before { destroy_post_path(owner, post) }

      it "пост не должен быть удален" do
        expect(Post.all).to include post
      end
    end

  end
end
