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

RSpec.describe "/external_urls", type: :request do
  
  # This should return the minimal set of attributes required to create a valid
  # ExternalUrl. As you add validations to ExternalUrl, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  describe "GET /index" do
    it "renders a successful response" do
      ExternalUrl.create! valid_attributes
      get external_urls_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      external_url = ExternalUrl.create! valid_attributes
      get external_url_url(external_url)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_external_url_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "renders a successful response" do
      external_url = ExternalUrl.create! valid_attributes
      get edit_external_url_url(external_url)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new ExternalUrl" do
        expect {
          post external_urls_url, params: { external_url: valid_attributes }
        }.to change(ExternalUrl, :count).by(1)
      end

      it "redirects to the created external_url" do
        post external_urls_url, params: { external_url: valid_attributes }
        expect(response).to redirect_to(external_url_url(ExternalUrl.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new ExternalUrl" do
        expect {
          post external_urls_url, params: { external_url: invalid_attributes }
        }.to change(ExternalUrl, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post external_urls_url, params: { external_url: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested external_url" do
        external_url = ExternalUrl.create! valid_attributes
        patch external_url_url(external_url), params: { external_url: new_attributes }
        external_url.reload
        skip("Add assertions for updated state")
      end

      it "redirects to the external_url" do
        external_url = ExternalUrl.create! valid_attributes
        patch external_url_url(external_url), params: { external_url: new_attributes }
        external_url.reload
        expect(response).to redirect_to(external_url_url(external_url))
      end
    end

    context "with invalid parameters" do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        external_url = ExternalUrl.create! valid_attributes
        patch external_url_url(external_url), params: { external_url: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested external_url" do
      external_url = ExternalUrl.create! valid_attributes
      expect {
        delete external_url_url(external_url)
      }.to change(ExternalUrl, :count).by(-1)
    end

    it "redirects to the external_urls list" do
      external_url = ExternalUrl.create! valid_attributes
      delete external_url_url(external_url)
      expect(response).to redirect_to(external_urls_url)
    end
  end
end
