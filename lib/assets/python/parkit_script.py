import argparse
import cv2
import numpy as np
import matplotlib.pyplot as plt
from sklearn.cluster import KMeans
import utils

ap = argparse.ArgumentParser()
ap.add_argument("-i", "--image", required=True, help="path to the image")
#ap.add_argument("-c", "--clusters", required = True, type = int,
#                help= "number of clusters")

args = vars(ap.parse_args())

image = cv2.imread(args["image"])

def draw_rect():
    #This is the part to get the ROIs
    #img = np.zeros((512,512,3), np.uint8)
    offset = 35
    length = 6
    init = 16
    height_x = 50
    height_y = 340
    width = 200
    color = (0,255,0)
    for i in range(length):
        x_pos = (init + offset +  i * width, height_x)
        y_pos = (init + (i+1) * width, height_y)
        x_posb = (init + offset +  i * width, height_y+30)
        y_posb = (init + (i+1) * width, 358+300)
        cv2.rectangle(image, x_pos, y_pos, color, 3)
        cv2.rectangle(image, x_posb, y_posb, color, 3)
    cv2.imshow('Normal', image)
    cv2.waitKey(0)
    #cv2.rectangle(image, (174 + i * 100, 100), (174 + (i+1) * 100, 358), (0,255,0),3)
    # cv2.rectangle(image, (100,100), (200,200), (0,255,0), 3)
    # cv2.rectangle(image, (200,200), (300,300), (0,255,0), 3)
    # roi = image[0:100, 0:100]
    # cv2.imshow('roi', roi)

def cont_find(img):
    COLOR_A = np.array([255,255,255], np.uint8)
    COLOR_B = np.array([255,255,255], np.uint8)
    roi = img[0:100, 0:100]
    black = cv2.cvtColor(roi, cv2.COLOR_BGR2GRAY)
    ret,thresh1 = cv2.threshold(black,127,255,cv2.THRESH_BINARY)
    dst = cv2.inRange(thresh1, 0, 0)
    mean = cv2.countNonZero(dst)
    print(mean)
    cv2.imshow('nor', thresh1)
    cv2.imshow('wa', roi)
    cv2.waitKey(0)



def roi_and_histogram():
    image = cv2.cvtColor(image, cv2.COLOR_BGR2RGB)
    roi = image[0:100, 0:100]
    plt.figure()
    plt.axis("off")
    plt.imshow(roi)
    plt.waitforbuttonpress()
    #cv2.imshow('normal', image)
    #cv2.waitKey(0)
    #cv2.waitKey(0)
    image = image.reshape((image.shape[0] * image.shape[1], 3))
    # cluster the pixel intensities
    reshape = roi.reshape((roi.shape[0] * roi.shape[1], 3))
    clt = KMeans(n_clusters = args["clusters"])
    clt.fit(reshape)

    hist = utils.centroid_histogram(clt)

    bar = utils.plot_colors(hist, clt.cluster_centers_)

    # show our color bart
    plt.figure()
    plt.axis("off")
    plt.imshow(bar)
    plt.show()

def calculate_spots():
    array_a = []
    array_b = []
    offset = 35
    length = 6
    init = 16
    height_x = 50
    height_y = 340
    width = 200
    color = (0,255,0)
    for i in range(length):
        x_pos = (init + offset +  i * width, height_x)
        y_pos = (init + (i+1) * width, height_y)
        roi = image[x_pos[1]:y_pos[1], x_pos[0]:y_pos[0]]
        #cv2.rectangle(image, x_pos, y_pos, color, 3)
        black = cv2.cvtColor(roi, cv2.COLOR_BGR2GRAY)
        ret, thresh1 = cv2.threshold(black, 115, 255, cv2.THRESH_BINARY)
        #th3 = cv2.adaptiveThreshold(black,255,cv2.ADAPTIVE_THRESH_GAUSSIAN_C,cv2.THRESH_BINARY,11,1)
        dst = cv2.inRange(thresh1, 0, 0)
        mean = cv2.countNonZero(dst)
        array_a.append(spot_occ(mean, thresh1.size))

        # Second row
        x_posb = (init + offset +  i * width, height_y+30)
        y_posb = (init + (i+1) * width, 358+300)
        roi_2 = image[x_posb[1]:y_posb[1], x_posb[0]:y_posb[0]]
        #cv2.rectangle(image, x_posb, y_posb, color, 3)
        black2 = cv2.cvtColor(roi_2, cv2.COLOR_BGR2GRAY)
        ret2, thresh2 = cv2.threshold(black2, 115, 255, cv2.THRESH_BINARY)
        dst2 = cv2.inRange(thresh2, 0, 0)
        mean2 = cv2.countNonZero(dst2)
        array_b.append(spot_occ(mean2, thresh2.size))
        #print(x_pos[0], x_pos[1])
        #print(y_pos[0], y_pos[1])
        #cv2.imshow('roi', roi)
        #cv2.imshow('black', thresh1)
        #cv2.waitKey(0)
    #cv2.imshow('wa', image)
    #cv2.waitKey(0)
    return (array_a, array_b)

def spot_occ(pixels, size):
    percent = pixels / size
    #print(pixels, percent)
    if percent < 0.1:
        return "green"
    elif percent < 0.4:
        return "orange"
    else:
        return "red"


#draw_rect()
#cont_find(image)
print(calculate_spots())
