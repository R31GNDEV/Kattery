import sys
from pathlib import Path

class bcolors:
    HEADER = '\033[95m'
    OKBLUE = '\033[94m'
    OKCYAN = '\033[96m'
    OKGREEN = '\033[92m'
    KOTAWINS = '\033[35m'
    PINK = '\033[91m'
    ENDC = '\033[0m'
    BOLD = '\033[1m'
    UNDERLINE = '\033[4m'

MH_MAGIC_64 = b'\xcf\xfa\xed\xfe'
CPU_TYPE_ARM64 = b'\x0c\x00\x00\x01'
CPU_SUBTYPE_IOS13 = b'\x02\x00\x00\x00'
CPU_SUBTYPE_IOS14 = b'\x02\x00\x00\x80'

IOS13_HEADER = MH_MAGIC_64 + CPU_TYPE_ARM64 + CPU_SUBTYPE_IOS13
IOS14_HEADER = MH_MAGIC_64 + CPU_TYPE_ARM64 + CPU_SUBTYPE_IOS14
HEADER_LEN = len(IOS13_HEADER)

def handle_file(file):
    buf = file.read_bytes()

    if len(buf) < HEADER_LEN:
        print(f'Handling....')
        return

    header = buf[:HEADER_LEN]
    buf = buf[HEADER_LEN:]

    if header == IOS13_HEADER:
        print(f'{bcolors.PINK}converting "{file.name}" CPU Subtype from iOS13 (00000002) to iOS14 (80000002)')
        print(f'{bcolors.KOTAWINS}Fuck Yeah Bitttchh!!! You just built a rootless copy of Kattery!')
        print(f'I like boobs & women.')
        file.write_bytes(IOS14_HEADER + buf)
    elif header == IOS14_HEADER:
        print(f'{bcolors.KOTAWINS}converting "{file.name}" CPU Subtype from iOS14 (80000002) to iOS13 (00000002)')
        file.write_bytes(IOS13_HEADER + buf)


def main():
    if len(sys.argv) != 2:
        print(f'USAGE: {sys.argv[0]} <path>')
        return

    path = sys.argv[1]
    path = Path(path)
    handle_file(path)


if __name__ == '__main__':
    main()