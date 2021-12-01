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

RSpec.describe "/aksis", type: :request do
  
  # Aksi. As you add validations to Aksi, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  describe "GET /index" do
    it "renders a successful response" do
      Aksi.create! valid_attributes
      get aksis_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      aksi = Aksi.create! valid_attributes
      get aksi_url(aksi)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_aksi_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "render a successful response" do
      aksi = Aksi.create! valid_attributes
      get edit_aksi_url(aksi)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Aksi" do
        expect {
          post aksis_url, params: { aksi: valid_attributes }
        }.to change(Aksi, :count).by(1)
      end

      it "redirects to the created aksi" do
        post aksis_url, params: { aksi: valid_attributes }
        expect(response).to redirect_to(aksi_url(Aksi.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Aksi" do
        expect {
          post aksis_url, params: { aksi: invalid_attributes }
        }.to change(Aksi, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post aksis_url, params: { aksi: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested aksi" do
        aksi = Aksi.create! valid_attributes
        patch aksi_url(aksi), params: { aksi: new_attributes }
        aksi.reload
        skip("Add assertions for updated state")
      end

      it "redirects to the aksi" do
        aksi = Aksi.create! valid_attributes
        patch aksi_url(aksi), params: { aksi: new_attributes }
        aksi.reload
        expect(response).to redirect_to(aksi_url(aksi))
      end
    end

    context "with invalid parameters" do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        aksi = Aksi.create! valid_attributes
        patch aksi_url(aksi), params: { aksi: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested aksi" do
      aksi = Aksi.create! valid_attributes
      expect {
        delete aksi_url(aksi)
      }.to change(Aksi, :count).by(-1)
    end

    it "redirects to the aksis list" do
      aksi = Aksi.create! valid_attributes
      delete aksi_url(aksi)
      expect(response).to redirect_to(aksis_url)
    end
  end
end