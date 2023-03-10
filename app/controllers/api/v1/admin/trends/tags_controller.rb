# frozen_string_literal: true

class Api::V1::Admin::Trends::TagsController < Api::V1::Trends::TagsController
  before_action -> { authorize_if_got_token! :'admin:read' }

  def index
    if current_user&.can?(:manage_taxonomies)
      render json: @tags, each_serializer: REST::Admin::TagSerializer
    else
      super
    end
  end

  private

  def enabled?
    super || current_user&.can?(:manage_taxonomies)
  end

  def tags_from_trends
    if current_user&.can?(:manage_taxonomies)
      Trends.tags.query
    else
      super
    end
  end
end
