class Api::V1::GraphitiController < ApplicationController
  include Graphiti::Rails::Responders
  skip_before_action :authenticate_user!, if: :has_valid_jwt?

  def has_valid_jwt?
    return false unless request.headers['Authorization'].present?
    begin
      jwt_payload = JWT.decode(
        request.headers['Authorization'].split(' ')[1],
        Rails.application.secret_key_base
      ).first

      user = User.find_by(id: jwt_payload.fetch("id"))

      if user.present?
        return true
      else
        return false
      end
    rescue JWT::ExpiredSignature, JWT::VerificationError, JWT::DecodeError
      return false
    end
  end
end
