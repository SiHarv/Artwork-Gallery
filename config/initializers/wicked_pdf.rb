# config/initializers/wicked_pdf.rb
WickedPdf.configure do |config|
  config.exe_path = '/Users/teambootyard/.rbenv/shims/wkhtmltopdf' # Automatically finds wkhtmltopdf binary
end
