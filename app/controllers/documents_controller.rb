class DocumentsController < ApplicationController
  def index
    documents = Document.all

    render json: documents
  end

  def create
    pdf = Cloudinary::Uploader.upload(params[:file])
    document = Document.create(name: params[:fileName], pdf: params[:file], project_id: params[:projectId])
    render json: document
  end
end
