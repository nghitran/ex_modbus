defmodule RtuTest do
  use ExUnit.Case

  test "wrap packet" do
    # read from 5100 (0x13EC), length 96 (0x0060)
    assert Modbus.Rtu.wrap_packet(<<0x03, 0x13EC::size(16), 0x0060::size(16)>>, 1) ==
    <<0x01, 0x03, 0x13, 0xEC, 0x00, 0x60, 0x80, 0x93>>
  end

  test "unwrap read coil status (function 0x01) packet" do
    wrapped = <<0x01, 0x01, 0x05, 0xcd, 0x6b, 0xb2, 0x0e, 0x1b, 0x45, 0xe6>>
    unwrapped = Modbus.Rtu.unwrap_packet(wrapped)
    assert unwrapped.slave_id == 1
    assert unwrapped.content_length == 5
    assert unwrapped.packet == <<0xcd, 0x6b, 0xb2, 0x0e, 0x1b>>
  end

  test "unwrap read coil status (function 0x02) packet" do
    wrapped = <<0x01, 0x02, 0x03, 0xac, 0xdb, 0x35, 0x20, 0x18>>
    unwrapped = Modbus.Rtu.unwrap_packet(wrapped)
    assert unwrapped.slave_id == 1
    assert unwrapped.content_length == 3
    assert unwrapped.packet == <<0xac, 0xdb, 0x35>>
  end

  test "unwrap read holding registers (function 0x03) packet" do
    wrapped = <<0x01, 0x03, 0x04, 0x01, 0x02, 0x03, 0x04, 0x47, 0x52>>
    unwrapped = Modbus.Rtu.unwrap_packet(wrapped)
    assert unwrapped.slave_id == 1
    assert unwrapped.content_length == 4
    assert unwrapped.packet == <<0x01, 0x02, 0x03, 0x04>>
  end

  test "unwrap read input registers (function 0x04) packet" do
    wrapped = <<0x01, 0x04, 0x02, 0x00, 0x0a, 0xfb, 0xf4>>
    unwrapped = Modbus.Rtu.unwrap_packet(wrapped)
    assert unwrapped.slave_id == 1
    assert unwrapped.content_length == 2
    assert unwrapped.packet == <<0x00, 0x0a>>
  end

  test "unwrap force single coil (function 0x05) packet" do
    wrapped = <<0x01, 0x05, 0x00, 0xac, 0xff, 0x00, 0x4e, 0x4b>>
    unwrapped = Modbus.Rtu.unwrap_packet(wrapped)
    assert unwrapped.slave_id == 1
    assert unwrapped.content_length == 5
    assert unwrapped.packet == <<0x05, 0x00, 0xac, 0xff, 0x00>>
  end

  test "unwrap preset single register (function 0x06) packet" do
    wrapped = <<0x01, 0x06, 0x00, 0x01, 0x00, 0x03, 0x9a, 0x9b>>
    unwrapped = Modbus.Rtu.unwrap_packet(wrapped)
    assert unwrapped.slave_id == 1
    assert unwrapped.content_length == 5
    assert unwrapped.packet == <<0x06, 0x00, 0x01, 0x00, 0x03>>
  end

  test "unwrap force multiple coils (function 0x0f) packet" do
    wrapped = <<0x01, 0x0f, 0x00, 0x013, 0x00, 0x0a, 0x26, 0x99>>
    unwrapped = Modbus.Rtu.unwrap_packet(wrapped)
    assert unwrapped.slave_id == 1
    assert unwrapped.content_length == 5
    assert unwrapped.packet == <<0x0f, 0x00, 0x013, 0x00, 0x0a>>
  end

  test "unwrap preset multiple registers (function 0x10) packet" do
    wrapped = <<0x01, 0x10, 0x00, 0x01, 0x00, 0x02, 0x12, 0x98>>
    unwrapped = Modbus.Rtu.unwrap_packet(wrapped)
    assert unwrapped.slave_id == 1
    assert unwrapped.content_length == 5
    assert unwrapped.packet == <<0x10, 0x00, 0x01, 0x00, 0x02>>
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
