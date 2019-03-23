import numpy as np
import seaborn as sns
import os


class Morie(object):
    """
    The parent class for future experiment.
    """

    def __init__(self):
        self.patterns = []
        self.directory = ''

    def generate_pattern(self,
                         width=1024,
                         height=728,
                         min_gray_value=50,
                         max_gray_value=200,
                         wavelength=30,
                         phase=0):
        """
        Generate the fringe pattern. save the image in Patterns directory.

        Inputs:
        width          - the horizontal dimension of the pattern image
        height         - the vertical dimension of the pattern image
        min_gray_value - the minium gray value
        max_gray_value - the maxium gray value
        wavelength     - the period of the pixel bwavelength
        phase          - the initial phase in the form of np.pi / interger

        Returns
        a seaborn image object in dimension of (height, width)
        """
        positions = np.ones([height, width]) * np.arange(0, width)
        pixels = (min_gray_value + max_gray_value) / 2 + \
            (max_gray_value - min_gray_value) / 2 * \
            np.sin(2 * np.pi * positions / wavelength + phase)
        pixels = pixels.astype(int)
        print(pixels)
        pattern = sns.heatmap(pixels,
                              cmap='gray',
                              cbar=False,
                              xticklabels=False,
                              yticklabels=False).get_figure()

        # check if the pattern is already generated
        fig_name = 'w' + str(width) + '_h' + str(height) + \
            '_' + str(min_gray_value) + "_" + \
            str(max_gray_value) + "_wl" + str(wavelength) + \
            '_p' + str(phase) + '.jpg'
        current_dir = os.getcwd()
        pattern_dir = r"../Patterns"
        os.chdir(pattern_dir)
        if fig_name in os.listdir():
            print("Pattern with the filename ---- " +
                  fig_name + " is already generated!")
        else:
            pattern.savefig(fig_name)
        os.chdir(current_dir)


morie = Morie()
morie.generate_pattern(wavelength=80)
