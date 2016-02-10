FFMPEG_BIN = "ffmpeg" 
import subprocess as sp
command = [ FFMPEG_BIN,
            '-i', 'http://187.217.216.173:80/mjpg/video.mjpg?COUNTER',
            '-f', 'image2pipe',
            '-pix_fmt', 'rgb24',
            '-vcodec', 'rawvideo', '-']
pipe = sp.Popen(command, stdout = sp.PIPE, bufsize=10**8)

import numpy
# read 420*360*3 bytes (= 1 frame)
raw_image = pipe.stdout.read(480*360*3)
# transform the byte read into a numpy array
image =  numpy.fromstring(raw_image, dtype='uint8')
image = image.reshape((360,480,3))


# throw away the data in the pipe's buffer.
pipe.stdout.flush()

import matplotlib.pyplot as plt
plt.imshow(image)
plt.show()


