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

RSpec.describe "/latar_belakangs", type: :request do
  
  # LatarBelakang. As you add validations to LatarBelakang, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  describe "GET /index" do
    it "renders a successful response" do
      LatarBelakang.create! valid_attributes
      get latar_belakangs_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      latar_belakang = LatarBelakang.create! valid_attributes
      get latar_belakang_url(latar_belakang)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_latar_belakang_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "render a successful response" do
      latar_belakang = LatarBelakang.create! valid_attributes
      get edit_latar_belakang_url(latar_belakang)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new LatarBelakang" do
        expect {
          post latar_belakangs_url, params: { latar_belakang: valid_attributes }
        }.to change(LatarBelakang, :count).by(1)
      end

      it "redirects to the created latar_belakang" do
        post latar_belakangs_url, params: { latar_belakang: valid_attributes }
        expect(response).to redirect_to(latar_belakang_url(LatarBelakang.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new LatarBelakang" do
        expect {
          post latar_belakangs_url, params: { latar_belakang: invalid_attributes }
        }.to change(LatarBelakang, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post latar_belakangs_url, params: { latar_belakang: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested latar_belakang" do
        latar_belakang = LatarBelakang.create! valid_attributes
        patch latar_belakang_url(latar_belakang), params: { latar_belakang: new_attributes }
        latar_belakang.reload
        skip("Add assertions for updated state")
      end

      it "redirects to the latar_belakang" do
        latar_belakang = LatarBelakang.create! valid_attributes
        patch latar_belakang_url(latar_belakang), params: { latar_belakang: new_attributes }
        latar_belakang.reload
        expect(response).to redirect_to(latar_belakang_url(latar_belakang))
      end
    end

    context "with invalid parameters" do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        latar_belakang = LatarBelakang.create! valid_attributes
        patch latar_belakang_url(latar_belakang), params: { latar_belakang: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested latar_belakang" do
      latar_belakang = LatarBelakang.create! valid_attributes
      expect {
        delete latar_belakang_url(latar_belakang)
      }.to change(LatarBelakang, :count).by(-1)
    end

    it "redirects to the latar_belakangs list" do
      latar_belakang = LatarBelakang.create! valid_attributes
      delete latar_belakang_url(latar_belakang)
      expect(response).to redirect_to(latar_belakangs_url)
    end
  end
end