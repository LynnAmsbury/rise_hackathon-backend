class PetitionsController < ApplicationController
  def index
    petitions = Petition.all 
    render json: petitions, include: [:signees]
  end

  def show
    petition = Petition.find(params[:id])
    render json: petition, include: [:signees]
  end

  def create
    petition = Petition.create(
      name: params[:name],
      description: params[:description],
      submit_to: params[:submit_to],
      signature_goal: params[:signature_goal]
    )
    render json: petition 
  end 

  def destroy
    petition = Petition.find(params[:id])
    petition.signatures.each do |signature|
      signature.destroy
    end
    petition.destroy 
    render status: :no_content
  end

  def add_signature
    petition = Petition.find(params[:id])
    signee = Signee.create(
      first_name: params[:first_name], 
      last_name: params[:last_name],
      address: params[:address]
    )
    Signature.create(petition: petition, signee: signee)
    render status: :ok
  end

  def update
    petition = Petition.find(params[:id])
    petition.update(
      name: params[:name],
      description: params[:description],
      submit_to: params[:submit_to],
      signature_goal: params[:signature_goal]
    )
    render json: petition
  end
end
