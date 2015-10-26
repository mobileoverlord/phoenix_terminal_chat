defmodule Mix.Tasks.Chat do
  use Mix.Task

  @shortdoc "Connect to chat server"
  @switches []

  def run(_) do
    {:ok, _} = TerminalChat.Socket.start_link
    {:ok, channel} = TerminalChat.Channel.start_link(socket: TerminalChat.Socket, topic: "rooms:lobby", sender: self)
    TerminalChat.Channel.join(channel)
    input(channel)
  end

  def input(channel, user \\ "terminal") do
    Mix.shell.prompt("#{user}: ")
    |> parse(channel, user)
    input(channel)
  end

  def parse(<<"/u ", username :: binary>>, channel, _) do
    input(channel, String.strip(username))
  end

  def parse(message, channel, user) do
    TerminalChat.Channel.send_message(channel, message, user)
    input(channel, user)
  end
end
