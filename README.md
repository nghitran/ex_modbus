ExModbus
========

[![Hex.pm](https://img.shields.io/hexpm/v/ex_modbus.svg?maxAge=18000=plastic)](https://hex.pm/packages/ex_modbus) [![Documentation](https://img.shields.io/badge/hexdocs-latest-blue.svg)](https://hexdocs.pm/ex_modbus/index.html)

An Elixir Modbus (TCP & RTU) client implementation.

RTU variant depends on [nerves_uart](http://www.github.com/nerves/nerves_uart) for serial connection.

## TCP Usage

```
  % iex -S mix

  iex(1)> {:ok, pid} = ExModbus.Client.start_link {10, 2, 3, 4}
  {:ok, #PID<0.79.0>}

  iex(2)> ExModbus.Client.read_data pid, 1, 0x1037, 1
  10:12:14.925 [debug] Packet: <<0, 1, 0, 0, 0, 6, 1, 3, 16, 55, 0, 1>>
  10:12:14.947 [debug] Response: <<0, 1, 0, 0, 0, 5, 1, 3, 2, 0, 0>>
  %{data: {:read_holding_registers, [0]}, transaction_id: 1, unit_id: 1}

  iex(3)> ExModbus.Client.generic_call pid, 1, ExModbus.Profile.Acuvim.property(:date_time)
  10:13:37.025 [debug] Packet: <<0, 1, 0, 0, 0, 6, 1, 3, 16, 64, 0, 6>>
  10:13:37.038 [debug] Response: <<0, 1, 0, 0, 0, 15, 1, 3, 12, 7, 212, 0, 11, 0, 29, 0, 0, 0, 52, 0, 7>>
  {{2004, 11, 29}, {0, 52, 7}}
```


## RTU Usage
```
  % iex -S mix

  iex(1)> {:ok, pid} = ExModbus.RtuClient.start_link%{tty: "/dev/ttyUSB0", speed: 9600}
  {:ok, #PID<0.79.0>}

  iex(2)> ExModbus.RtuClient.read_data pid, 1, 0x1037, 1
  10:12:14.925 [debug] Packet: <<0, 1, 0, 0, 0, 6, 1, 3, 16, 55, 0, 1>>
  10:12:14.947 [debug] Response: <<0, 1, 0, 0, 0, 5, 1, 3, 2, 0, 0>>
  %{data: {:read_holding_registers, [0]}, transaction_id: 1, unit_id: 1}
```



## License

See the [LICENSE](LICENSE.md) file for license rights and limitations (MIT).
