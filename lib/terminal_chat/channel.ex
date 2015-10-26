defmodule TerminalChat.Channel do
  use Phoenix.Channel.Client.Server

  def send_message(channel, message, user \\ "terminal") do
    __MODULE__.push(channel, "new:msg", %{user: user, body: message})
  end

  def handle_in(event, %{"body" => "ping"}, state) do
    {:noreply, state}
  end

  def handle_in(event, %{"user" => user, "body" => msg}, state) do
    #Logger.debug "[#{user}] #{msg}"
    IO.puts "\n[#{user}] #{msg}"
    {:noreply, state}
  end

  def handle_in(event, _, state) do
    {:noreply, state}
  end

  def handle_reply({:ok, :join, payload, ref}, state) do
    #Logger.debug "[channel] joined"
    {:noreply, state}
  end

  def handle_reply(payload, state) do
    {:noreply, state}
  end

  def handle_close(payload, state) do
    {:noreply, state}
  end
end
