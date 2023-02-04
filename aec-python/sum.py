# sum.py

import argparse

parser = argparse.ArgumentParser(description = "Sum two integers.") 

parser.add_argument("ints_to_sum", nargs=2, type=int)

args = parser.parse_args()

our_sum = sum(args.ints_to_sum)

print(f'The sum of your values values is: {our_sum}')

l = [10,5,4]
our_sub = 0
for i in l:
    if l[i] == 0:
        our_sub = i
        print(f'first i = {i}')
        print(f'first our_sub = {i}')
    elif l[i] > 0:
        our_sub -= i
        print(f'next i = {i}')
        print(f'next our_sub = {i}')

print(f'The subtracted result of your values: {our_sub}')
