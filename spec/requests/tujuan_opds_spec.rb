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

RSpec.describe "/tujuan_opds", type: :request do
  
  # This should return the minimal set of attributes required to create a valid
  # TujuanOpd. As you add validations to TujuanOpd, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  describe "GET /index" do
    it "renders a successful response" do
      TujuanOpd.create! valid_attributes
      get tujuan_opds_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      tujuan_opd = TujuanOpd.create! valid_attributes
      get tujuan_opd_url(tujuan_opd)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_tujuan_opd_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "renders a successful response" do
      tujuan_opd = TujuanOpd.create! valid_attributes
      get edit_tujuan_opd_url(tujuan_opd)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new TujuanOpd" do
        expect {
          post tujuan_opds_url, params: { tujuan_opd: valid_attributes }
        }.to change(TujuanOpd, :count).by(1)
      end

      it "redirects to the created tujuan_opd" do
        post tujuan_opds_url, params: { tujuan_opd: valid_attributes }
        expect(response).to redirect_to(tujuan_opd_url(TujuanOpd.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new TujuanOpd" do
        expect {
          post tujuan_opds_url, params: { tujuan_opd: invalid_attributes }
        }.to change(TujuanOpd, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post tujuan_opds_url, params: { tujuan_opd: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested tujuan_opd" do
        tujuan_opd = TujuanOpd.create! valid_attributes
        patch tujuan_opd_url(tujuan_opd), params: { tujuan_opd: new_attributes }
        tujuan_opd.reload
        skip("Add assertions for updated state")
      end

      it "redirects to the tujuan_opd" do
        tujuan_opd = TujuanOpd.create! valid_attributes
        patch tujuan_opd_url(tujuan_opd), params: { tujuan_opd: new_attributes }
        tujuan_opd.reload
        expect(response).to redirect_to(tujuan_opd_url(tujuan_opd))
      end
    end

    context "with invalid parameters" do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        tujuan_opd = TujuanOpd.create! valid_attributes
        patch tujuan_opd_url(tujuan_opd), params: { tujuan_opd: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested tujuan_opd" do
      tujuan_opd = TujuanOpd.create! valid_attributes
      expect {
        delete tujuan_opd_url(tujuan_opd)
      }.to change(TujuanOpd, :count).by(-1)
    end

    it "redirects to the tujuan_opds list" do
      tujuan_opd = TujuanOpd.create! valid_attributes
      delete tujuan_opd_url(tujuan_opd)
      expect(response).to redirect_to(tujuan_opds_url)
    end
  end
end
