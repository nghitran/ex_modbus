defmodule Crc16Test do
  use ExUnit.Case

  test "find crc16 for read multiple command" do
    assert Modbus.Crc16.crc_16(<<0x01, 0x03, 0x13, 0xec, 0x00, 0x60>>) == 0x9380
  end

end
