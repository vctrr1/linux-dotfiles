#!/usr/bin/env python3

import time
import subprocess
from evdev import InputDevice, list_devices, ecodes

CONTROLLER_NAME = "8BitDo Ultimate Wireless / Pro 2 Wired Controller"
SCRIPT = "/home/victor/.local/bin/steam-bigpicture-focus.sh"


def find_controller():
    for path in list_devices():
        try:
            device = InputDevice(path)
            if device.name == CONTROLLER_NAME:
                return device
            device.close()
        except OSError:
            continue

    return None


while True:
    controller = find_controller()

    if controller is None:
        print("Controle 8BitDo não encontrado. Tentando novamente...", flush=True)
        time.sleep(3)
        continue

    print(f"Monitorando: {controller.name} ({controller.path})", flush=True)

    try:
        for event in controller.read_loop():
            if (
                event.type == ecodes.EV_KEY
                and event.code == ecodes.BTN_MODE
                and event.value == 1
            ):
                print("Botão Home pressionado.", flush=True)
                subprocess.Popen([SCRIPT])

    except OSError as error:
        print(f"Controle desconectado: {error}", flush=True)

    finally:
        controller.close()

    time.sleep(2)
