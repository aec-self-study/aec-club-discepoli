import unittest
from calc import aec_divide

class TestDivide(unittest.TestCase):
    def test_divide(self):
        args_ints = [20, 5]
        div_result = aec_divide(args_ints)
        self.assertEqual(div_result, 4)

if __name__ == "__main__":
    unittest.main()