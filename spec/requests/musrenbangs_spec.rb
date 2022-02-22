 require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to test the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator. If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails. There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.

RSpec.describe "/musrenbangs", type: :request do
  
  # Musrenbang. As you add validations to Musrenbang, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  describe "GET /index" do
    it "renders a successful response" do
      Musrenbang.create! valid_attributes
      get musrenbangs_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      musrenbang = Musrenbang.create! valid_attributes
      get musrenbang_url(musrenbang)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_musrenbang_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "render a successful response" do
      musrenbang = Musrenbang.create! valid_attributes
      get edit_musrenbang_url(musrenbang)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Musrenbang" do
        expect {
          post musrenbangs_url, params: { musrenbang: valid_attributes }
        }.to change(Musrenbang, :count).by(1)
      end

      it "redirects to the created musrenbang" do
        post musrenbangs_url, params: { musrenbang: valid_attributes }
        expect(response).to redirect_to(musrenbang_url(Musrenbang.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Musrenbang" do
        expect {
          post musrenbangs_url, params: { musrenbang: invalid_attributes }
        }.to change(Musrenbang, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post musrenbangs_url, params: { musrenbang: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested musrenbang" do
        musrenbang = Musrenbang.create! valid_attributes
        patch musrenbang_url(musrenbang), params: { musrenbang: new_attributes }
        musrenbang.reload
        skip("Add assertions for updated state")
      end

      it "redirects to the musrenbang" do
        musrenbang = Musrenbang.create! valid_attributes
        patch musrenbang_url(musrenbang), params: { musrenbang: new_attributes }
        musrenbang.reload
        expect(response).to redirect_to(musrenbang_url(musrenbang))
      end
    end

    context "with invalid parameters" do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        musrenbang = Musrenbang.create! valid_attributes
        patch musrenbang_url(musrenbang), params: { musrenbang: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested musrenbang" do
      musrenbang = Musrenbang.create! valid_attributes
      expect {
        delete musrenbang_url(musrenbang)
      }.to change(Musrenbang, :count).by(-1)
    end

    it "redirects to the musrenbangs list" do
      musrenbang = Musrenbang.create! valid_attributes
      delete musrenbang_url(musrenbang)
      expect(response).to redirect_to(musrenbangs_url)
    end
  end
end