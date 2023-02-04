import random
 
denoms = list(range(10))
random.shuffle(denoms)
 
for i in range(10):
    x = denoms[i]
    try:
        result = 100 / x
    except:
        import pdb; pdb.set_trace()
        