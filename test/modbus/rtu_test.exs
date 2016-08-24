defmodule RtuTest do
  use ExUnit.Case

  test "wrap packet" do
    # read from 5100 (0x13EC), length 96 (0x0060)
    assert Modbus.Rtu.wrap_packet(<<0x03, 0x13EC::size(16), 0x0060::size(16)>>, 1) ==
    <<0x01, 0x03, 0x13, 0xEC, 0x00, 0x60, 0x80, 0x93>>
  end

  test "unwrap packet" do
    wrapped = <<0x01, 0x03, 0x04, 0x00, 0x01, 0x02, 0x03, 0x04, 0x47, 0x52>>
    unwrapped = Modbus.Rtu.unwrap_packet(wrapped)
    assert unwrapped.slave_id == 1
    assert unwrapped.content_length == 4
    assert unwrapped.packet == <<0x01, 0x02, 0x03, 0x04>>
  end
  #
  # test "unwrap packet" do
  #   wrapped = <<0x0006::size(16), 0x0000::size(16), 0x0006::size(16), 0x20,
  #     0x03, 0x006b::size(16), 0x0003::size(16)>>
  #   unwrapped = Modbus.Tcp.unwrap_packet(wrapped)
  #   assert unwrapped.unit_id == 32
  #   assert unwrapped.transaction_id == 6
  #   assert unwrapped.packet == <<0x03, 0x006b::size(16), 0x0003::size(16)>>
  # end
end
