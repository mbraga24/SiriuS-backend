class ArchiveDocumentsController < ApplicationController
  
  def index
    arch_documents = ArchiveDocument.all
    render json: arch_documents
  end

  def show
    arch_document = ArchiveDocument.find_by(id: params[:id])
    render json: arch_document
  end

end
