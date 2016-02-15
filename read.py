import os

import numpy
import matplotlib.pyplot as plt

FFMPEG_BIN = "ffmpeg" 
import subprocess as sp
command = [ FFMPEG_BIN,
            '-i', 'http://187.217.216.173:80/mjpg/video.mjpg',
            '-f', 'image2pipe',
            '-pix_fmt', 'rgb24',
            '-vcodec', 'rawvideo', '-']
pipe = sp.Popen(command, stdout = sp.PIPE, bufsize=10**8)


raw_image = pipe.stdout.read(480*360*3)

image =  numpy.fromstring(raw_image, dtype='uint8')
image = image.reshape((360,480,3))


pipe.stdout.flush()


plt.imshow(image)
plt.show()


