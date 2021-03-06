class SearchController < ApplicationController
  before_action :logged_in
  
  def index
    @title = "Search"
    @cur_url = "/search"
    @files  = []
    @page_number = []

    @search = Search.new

    if params[:q].to_s.present?
      @search.q = params[:q].to_s
      search_pdf_keywords params[:q].to_s

      if params[:what].present?
        @search.what = params[:what]
      end
      if params[:order].present?
        @search.order = params[:order]
      end
      if params[:page].present?
        @search.page = params[:page].to_i
      end

      if @search.valid?
        @search.search_for_user!(@user)
      end

    end

    render :action => "index"
  end

  private

  def search_pdf_keywords(query)
    Story.all.each do |story|
      next unless story.attachment? && story.attachment.file.extension == 'pdf'
      io = open(story.attachment.file.path)
      reader = PDF::Reader.new(io)
      reader.pages.each do |page|
        string = page.text
        query.split(' ').each do |word|
          if string.downcase.include?(word.downcase)
            @files.push(story)
            @page_number.push page.number
            next
          end
        end
      end
    end
  end
end
