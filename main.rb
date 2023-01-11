require './app'
class Main
  def main
    app = App.new
    app.options
  end
end

main = Main.new

main.main
