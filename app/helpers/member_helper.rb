# frozen_string_literal: true

module MemberHelper
  def comment_link(comment, commented_articles, commented_discussions)
    if comment.commentable_type.include? "Article"
      commented_articles.each do |article|
        if article.id.equal?(comment.commentable_id)
          path = article_details_path(article.category.slug, article.slug)
          return link_to(article.name, path)
        end
      end
    elsif comment.commentable_type.include? "Discussion"
      commented_discussions.each do |discussion|
        if discussion.id.equal?(comment.commentable_id)
          path = discussion_details_path(discussion.category.slug, discussion.slug)
          return link_to(discussion.name, path)
        end
      end
    end
  end
end
