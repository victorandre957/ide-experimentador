# = HelloController
#
# Controller responsible for handling hello-related actions.

class HelloController < ApplicationController
  # world method
  #
  # This method assigns a test text to an instance variable.
  #
  # Parameters:
  #   No parameters required.
  #
  # Assigns the text "teste" to the instance variable @texto.
  def world
    @texto = "teste"
  end

  # index method
  #
  # This method renders a JSON response with the text "teste1".
  #
  # Parameters:
  #   No parameters required.
  #
  # Renders a JSON response containing the string "teste1".
  def index
    render json: "teste1"
  end
end
