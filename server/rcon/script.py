import sys
import factorio_rcon

client = factorio_rcon.RCONClient("0.0.0.0", int(sys.argv[1]), sys.argv[2])

params = ""
if len(sys.argv) > 4:
    params = sys.argv[4]

res = client.send_command(sys.argv[3] + " " + params)
print(res)
