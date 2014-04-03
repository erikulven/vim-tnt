import unittest
import vim_tnt as sut


@unittest.skip("Don't forget to test!")
class VimTntTests(unittest.TestCase):

    def test_example_fail(self):
        result = sut.vim_tnt_example()
        self.assertEqual("Happy Hacking", result)
