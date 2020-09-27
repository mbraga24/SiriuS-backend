class DocumentsController < ApplicationController
  def index
    documents = Document.all

    render json: documents
  end

  def create
    # byebug
    img_file = Cloudinary::Uploader.upload(params[:file], "format" => 'jpg')
    document = Document.create(name: params[:fileName], url: img_file["url"], project_id: params[:projectId])
    render json: document
  end
end
