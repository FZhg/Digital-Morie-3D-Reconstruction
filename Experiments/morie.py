import numpy as np
import seaborn as sns
import os

class Morie(object):
	"""
	The parent class for future experiment.
	"""
	def __init__(self):
		self.patterns = []
		
	def generate_pattern(self, width=1024, height=728, min_gray_value=50, max_gray_value=200, wavelength=30, phase=0):
		"""
		Generate the fringe pattern. save the image in Patterns directory.

		Inputs:
		width          - the horizontal dimension of the pattern image
		height         - the vertical dimension of the pattern image
		min_gray_value - the minium gray value
		max_gray_value - the maxium gray value
		wavelength     - the period of the pixel wavelength 
		phase          - the initial phase

		Returns
		a seaborn image object in dimension of (height, width)
		"""
		positions = np.ones([height, width]) * np.arange(1, width + 1)
		pixels = min_gray_value + (max_gray_value - min_gray_value) * np.sin( 2 * np.pi * positions / wavelength + phase)
		pattern = sns.heatmap(pixels, cmap='gray', cbar=False, xticklabels=False, yticklabels=False).get_figure()
		pattern.savefig('output.png')



morie = Morie()
morie.generate_pattern()
