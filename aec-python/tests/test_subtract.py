import unittest
from calc import aec_subtract

class TestSubtract(unittest.TestCase):
    def test_subtract(self):
        args_ints = [20, 5]
        sub_result = aec_subtract(args_ints)
        self.assertEqual(sub_result, 15)
    
    def test_cant_go_below_zero(self):
        args_ints = [5, 20]
        sub_result = aec_subtract(args_ints)
        self.assertEqual(sub_result, 0)

    def test_just_use_two(self):
        args_ints = [5, 20, 1]
        sub_result = aec_subtract(args_ints)
        self.assertRaises(sub_result, "Sorry, use only 2 numbers")

if __name__ == "__main__":
    unittest.main()