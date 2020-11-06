class DocumentsController < ApplicationController
  def index
    documents = Document.all.order('created_at ASC')
    
    render json: documents
  end
  
  def create
    pdf_file = Cloudinary::Uploader.upload(params[:file], :pages => true)

    document = Document.create(name: params[:fileName], url: pdf_file["url"], project_id: params[:projectId], user_id: params[:userId])
    render json: document
  end
end
