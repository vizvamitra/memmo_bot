class HelpCommand < BaseCommand
  def run
    respond_with( text: i18n(:message) )
  end
end