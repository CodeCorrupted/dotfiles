#!/usr/bin/env python3
import subprocess
import time

max_length = 20  # Caracteres visibles
scroll_speed = 0.2  # Segundos por paso
separator = " — "  # Separador título-artista


def get_metadata():
    try:
        title = (
            subprocess.check_output(
                ["mpc", "-f", "%title%"], text=True, stderr=subprocess.DEVNULL
            )
            .strip()
            .split("\n")[0]
        )

        artist = (
            subprocess.check_output(
                ["mpc", "-f", "%artist%"], text=True, stderr=subprocess.DEVNULL
            )
            .strip()
            .split("\n")[0]
        )

        if artist and title:
            full_text = f"{title}{separator}{artist}"
        else:
            full_text = subprocess.check_output(["mpc", "current"], text=True).strip()

        return full_text.replace("\n", " ")[:200]  # Limpiar y limitar longitud

    except:
        return "MPD Desconectado"


def infinite_scroll(text, width):
    text = text + " " * width  # Espacio para el efecto de transición
    extended_text = text * 2  # Duplicar para simular continuidad

    pos = 0
    while True:
        # Obtener segmento actual
        segment = extended_text[pos : pos + width]
        # Avanzar posición con wrap-around
        pos = (pos + 1) % len(text)
        yield segment.ljust(width)


if __name__ == "__main__":
    current_text = ""
    scroller = infinite_scroll("Esperando música...", max_length)

    while True:
        new_text = get_metadata()

        if new_text != current_text:
            current_text = new_text
            scroller = infinite_scroll(new_text, max_length)

        print(next(scroller))
        time.sleep(scroll_speed)
