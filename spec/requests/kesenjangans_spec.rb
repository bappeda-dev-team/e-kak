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

RSpec.describe "/kesenjangans", type: :request do
  
  # Kesenjangan. As you add validations to Kesenjangan, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  describe "GET /index" do
    it "renders a successful response" do
      Kesenjangan.create! valid_attributes
      get kesenjangans_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      kesenjangan = Kesenjangan.create! valid_attributes
      get kesenjangan_url(kesenjangan)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_kesenjangan_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "render a successful response" do
      kesenjangan = Kesenjangan.create! valid_attributes
      get edit_kesenjangan_url(kesenjangan)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Kesenjangan" do
        expect {
          post kesenjangans_url, params: { kesenjangan: valid_attributes }
        }.to change(Kesenjangan, :count).by(1)
      end

      it "redirects to the created kesenjangan" do
        post kesenjangans_url, params: { kesenjangan: valid_attributes }
        expect(response).to redirect_to(kesenjangan_url(Kesenjangan.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Kesenjangan" do
        expect {
          post kesenjangans_url, params: { kesenjangan: invalid_attributes }
        }.to change(Kesenjangan, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post kesenjangans_url, params: { kesenjangan: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested kesenjangan" do
        kesenjangan = Kesenjangan.create! valid_attributes
        patch kesenjangan_url(kesenjangan), params: { kesenjangan: new_attributes }
        kesenjangan.reload
        skip("Add assertions for updated state")
      end

      it "redirects to the kesenjangan" do
        kesenjangan = Kesenjangan.create! valid_attributes
        patch kesenjangan_url(kesenjangan), params: { kesenjangan: new_attributes }
        kesenjangan.reload
        expect(response).to redirect_to(kesenjangan_url(kesenjangan))
      end
    end

    context "with invalid parameters" do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        kesenjangan = Kesenjangan.create! valid_attributes
        patch kesenjangan_url(kesenjangan), params: { kesenjangan: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested kesenjangan" do
      kesenjangan = Kesenjangan.create! valid_attributes
      expect {
        delete kesenjangan_url(kesenjangan)
      }.to change(Kesenjangan, :count).by(-1)
    end

    it "redirects to the kesenjangans list" do
      kesenjangan = Kesenjangan.create! valid_attributes
      delete kesenjangan_url(kesenjangan)
      expect(response).to redirect_to(kesenjangans_url)
    end
  end
end