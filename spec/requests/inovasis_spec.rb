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

RSpec.describe "/inovasis", type: :request do
  
  # Inovasi. As you add validations to Inovasi, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  describe "GET /index" do
    it "renders a successful response" do
      Inovasi.create! valid_attributes
      get inovasis_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      inovasi = Inovasi.create! valid_attributes
      get inovasi_url(inovasi)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_inovasi_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "render a successful response" do
      inovasi = Inovasi.create! valid_attributes
      get edit_inovasi_url(inovasi)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Inovasi" do
        expect {
          post inovasis_url, params: { inovasi: valid_attributes }
        }.to change(Inovasi, :count).by(1)
      end

      it "redirects to the created inovasi" do
        post inovasis_url, params: { inovasi: valid_attributes }
        expect(response).to redirect_to(inovasi_url(Inovasi.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Inovasi" do
        expect {
          post inovasis_url, params: { inovasi: invalid_attributes }
        }.to change(Inovasi, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post inovasis_url, params: { inovasi: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested inovasi" do
        inovasi = Inovasi.create! valid_attributes
        patch inovasi_url(inovasi), params: { inovasi: new_attributes }
        inovasi.reload
        skip("Add assertions for updated state")
      end

      it "redirects to the inovasi" do
        inovasi = Inovasi.create! valid_attributes
        patch inovasi_url(inovasi), params: { inovasi: new_attributes }
        inovasi.reload
        expect(response).to redirect_to(inovasi_url(inovasi))
      end
    end

    context "with invalid parameters" do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        inovasi = Inovasi.create! valid_attributes
        patch inovasi_url(inovasi), params: { inovasi: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested inovasi" do
      inovasi = Inovasi.create! valid_attributes
      expect {
        delete inovasi_url(inovasi)
      }.to change(Inovasi, :count).by(-1)
    end

    it "redirects to the inovasis list" do
      inovasi = Inovasi.create! valid_attributes
      delete inovasi_url(inovasi)
      expect(response).to redirect_to(inovasis_url)
    end
  end
end