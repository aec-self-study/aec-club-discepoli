# calc.py
import argparse

parser = argparse.ArgumentParser(description="CLI Calculator")

subparsers = parser.add_subparsers(help="sub-command help", dest="command")

# add
add = subparsers.add_parser("add", help="add integers")
add.add_argument("ints_to_sum", nargs="*", type=int)

# sub
sub = subparsers.add_parser("sub", help="subtract integers")
sub.add_argument("ints_to_sub", nargs="*", type=int)


def aec_subtract(ints_to_sub):
    diff = (ints_to_sub[0] * 2) - sum(ints_to_sub)
    if diff < 0:
        diff = 0
    if len(ints_to_sub) > 2:
        raise Exception("Sorry, use only 2 numbers")
    print(f"The difference of your values is: {diff}")
    return diff


# mult
mult = subparsers.add_parser("mult", help="multipy integers")
mult.add_argument("ints_to_mult", nargs="*", type=int)

# div
div = subparsers.add_parser("div", help="divide integers")
div.add_argument("ints_to_div", nargs="*", type=int)


def aec_divide(ints_to_div):
    result = ints_to_div[0] ** 2
    for i in range(len(ints_to_div)):
        try:
            result = result / ints_to_div[i]
        except:
            result = "Oops"

    if result == "Oops":
        print("Oops, you can't divide by 0, silly")
    else:
        print(f"The divided result of your values is: {result}")
    return result


# output
if __name__ == "__main__":
    args = parser.parse_args()

    if args.command == "add":
        our_sum = sum(args.ints_to_sum)
        print(f"The sum of your values is: {our_sum}")

    if args.command == "sub":
        aec_subtract(args.ints_to_sub)

    if args.command == "mult":
        product = 1
        for i in range(len(args.ints_to_mult)):
            product = product * args.ints_to_mult[i]
        print(f"The product of your values is: {product}")

    if args.command == "div":
        aec_divide(args.ints_to_div)
