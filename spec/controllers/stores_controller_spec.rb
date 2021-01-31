require 'rails_helper'

RSpec.describe StoresController, type: :controller do
  describe "GET #index" do
    it "assigns nil as @current_store for no store_id param" do
      create_transaction_types

      valid_file = File.join(Rails.root, 'spec', 'fixtures', 'valid_cnab_file.txt')
      cnab = CnabParser.new(valid_file)
      cnab.parse
      Order.save_from_cnab_content(cnab.content)  
        
      get :index, params: {}
      expect(assigns(:current_store)).to be_nil
    end

    it "assigns nil as @current_store for a invalid store_id param" do
      create_transaction_types

      valid_file = File.join(Rails.root, 'spec', 'fixtures', 'valid_cnab_file.txt')
      cnab = CnabParser.new(valid_file)
      cnab.parse
      Order.save_from_cnab_content(cnab.content)  
        
      get :index, params: { store_id: 'X' }
      expect(assigns(:current_store)).to be_nil
    end

    it "assigns nil as @current_store for a valid store_id param" do
      create_transaction_types

      valid_file = File.join(Rails.root, 'spec', 'fixtures', 'valid_cnab_file.txt')
      cnab = CnabParser.new(valid_file)
      cnab.parse
      Order.save_from_cnab_content(cnab.content)  
        
      get :index, params: { store_id: Store.first.id }
      expect(assigns(:current_store)).to eq(Store.first)
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end

  describe "POST #upload" do
    after do
      FileUtils.rm_rf(File.join(Rails.root, 'storage-test'))
    end

    before do
      create_transaction_types
      FileUtils.rm_rf(File.join(Rails.root, 'storage-test'))
    end

    it "valid file uploaded error should be nil" do
      source_file_path = File.join(Rails.root, 'spec', 'fixtures', 'valid_cnab_file.txt')
      destiny_file_path = File.join(Rails.root, 'storage', 'valid_cnab_file.txt')
      post :upload, params: { file: Rack::Test::UploadedFile.new(source_file_path) }
      expect(assigns(:error)).to be_nil

      FileUtils.rm_f(destiny_file_path)
    end

    it "should set error as 'File already exists' if try to upload same valid file again" do
      source_file_path = File.join(Rails.root, 'spec', 'fixtures', 'valid_cnab_file.txt')
      destiny_file_path = File.join(Rails.root, 'storage', 'valid_cnab_file.txt')
      post :upload, params: { file: Rack::Test::UploadedFile.new(source_file_path) }

      post :upload, params: { file: Rack::Test::UploadedFile.new(source_file_path) }
      expect(assigns(:error)).to eq('File already exists')

      FileUtils.rm_f(destiny_file_path)
    end

    it "should set a specif error form a invalid file" do
      source_file_path = File.join(Rails.root, 'spec', 'fixtures', 'invalid_value_cnab_file.txt')
      post :upload, params: { file: Rack::Test::UploadedFile.new(source_file_path) }

      expect(assigns(:error)).not_to be_nil
    end

    it "should set error as 'Uploaded file is invalid' when file not sent" do
      post :upload
      expect(assigns(:error)).to eq('Uploaded file is invalid')
    end

    it "renders the upload template" do
      post :upload
      expect(response).to render_template("upload")
    end
  end
end
