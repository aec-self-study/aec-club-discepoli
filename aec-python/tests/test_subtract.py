import unittest
from calc import aec_subtract

class TestSubtract(unittest.TestCase):
    def test_subtract(self):
        args_ints = [20, 5]
        sub_result = aec_subtract(args_ints)
        self.assertEqual(sub_result, 15)

if __name__ == "__main__":
    unittest.main()