x = 2
print(x)

i = 1
while i < 5:
    print(i)
    i += 1


fruits = {"a": "apple", "b": "banana", "c": "clementine"}

for letter in fruits:
    print(fruits[letter])


def is_even(n):
    return n % 2 == 0


def is_odd(n):
    return n % 2 != 0


is_even(2)
is_even(5)
is_odd(2)
is_odd(5)


def describe_eveness(n):
    if is_even(n):
        print("It's Even Stevens, baby!")
    elif is_odd(n):
        print("It's Oddly Toddly, nugget!")
    else:
        print("Nahhhhr!")


describe_eveness(2)
describe_eveness(5)
describe_eveness(2.2)

my_first_list = ["apple", 1, "banana", 2]
cal_lookup = {"apple": 95, "banana": 105, "orange": 45}

for item in my_first_list:
    if type(item) == int:
        item**2
    elif type(item) == str:
        print(cal_lookup[item])


def sq_dict(dict):
    for item in dict:
        print(dict[item] ** 2)


sq_dict(cal_lookup)
