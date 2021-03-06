# Taken from curio: https://github.com/dabeaz/curio

# A simple echo server

from curio import Kernel, new_task, run_server
from socket import *


async def echo_handler(client, addr):
    print('Connection from', addr)
    try:
        client.setsockopt(IPPROTO_TCP, TCP_NODELAY, 1)
    except (OSError, NameError):
        pass

    while True:
        data = await client.recv(102400)
        if not data:
            break
        await client.sendall(data)
    print('Connection closed')

if __name__ == '__main__':
    kernel = Kernel()
    kernel.run(run_server('', 25000, echo_handler))
