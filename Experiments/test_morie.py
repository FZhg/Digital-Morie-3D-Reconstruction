import morie
import unittest

class Test(unittest.TestCase):
	def test_pattern_image(self):
		self.morie = Morie()
		self.morie.generate_pattern()


if __name__ == '_main_':
	unittest.main()
