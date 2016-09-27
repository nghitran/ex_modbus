defmodule Modbus.Rtu do
  @moduledoc """
  Wrap and parse Modbus RTU packets.
  """

  alias Modbus.Crc16

  @slave_id 0x0001

  @doc """
  Wrap `packet` in the Modbus Application Header appropriate for TCP/IP transport.
  """
  def wrap_packet(packet, slave_id) do
    packet_with_slave = <<slave_id::size(8), packet::binary>>
    <<slave_id::size(8), packet::binary, Crc16.crc_16(packet_with_slave)::size(16)-little>>
  end

  # read multiple registers
  def unwrap_packet(<<slave_id::size(8), 3, packet::binary>>) do
    <<length::size(8), _pkt::binary>> = packet
    packet_without_crc = Kernel.binary_part(packet, 0, length+2) # +2 because this includes the command and length bytes, plus our data length
    %{content_length: length, slave_id: slave_id, packet: packet_without_crc}
  end

  # write multiple registers
  def unwrap_packet(<<slave_id::size(8), 16, packet::binary>>) do
    %{content_length: 8, slave_id: slave_id, packet: packet}
  end

end
