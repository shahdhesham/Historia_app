# USAGE
# python predict_video.py --model model/activity.model --label-bin model/lb.pickle --input example_clips/lifting.mp4 --output output/lifting_128avg.avi --size 128

# import the necessary packages
def predict(video):
    from tensorflow.keras.models import load_model
    from collections import deque
    import numpy as np
    import argparse
    import pickle
    from cv2 import cv2

    print("[INFO] loading model and label binarizer...")
    model = load_model("C:/Users/EGYPT_LAPTOP/Desktop/GUI_GP/assets/Smodel.h5")
    lb = pickle.loads(open("C:/Users/EGYPT_LAPTOP/Desktop/GUI_GP/assets/Spickle.pickle", "rb").read())
    output="C:/Users/EGYPT_LAPTOP/Desktop/GUI_GP/assets//soccer_output.avi"

    # initialize the image mean for mean subtraction along with the
    # predictions queue
    mean = np.array([123.68, 116.779, 103.939][::1], dtype="float32")
    Q = deque(maxlen=128)
    # initialize the video stream, pointer to output video file, and
    # frame dimensions
    vs= video
    writer = None
    (W, H) = (None, None)
    imgArray=[]
    # loop over frames from the video file stream
    while True:
        # read the next frame from the file
        (grabbed, frame) = vs.read()

        # if the frame was not grabbed, then we have reached the end
        # of the stream
        if not grabbed:
            break

        # if the frame dimensions are empty, grab them
        if W is None or H is None:
            (H, W) = frame.shape[:2]

        # clone the output frame, then convert it from BGR to RGB
        # ordering, resize the frame to a fixed 224x224, and then
        # perform mean subtraction
        output = frame.copy()
        frame = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)
        frame = cv2.resize(frame, (224, 224)).astype("float32")
        frame -= mean
        size=(W,H)
        # make predictions on the frame and then update the predictions
        
        preds = model.predict(np.expand_dims(frame, axis=0))[0]
        Q.append(preds)

        # perform prediction averaging over the current history of
        # previous predictions
        results = np.array(Q).mean(axis=0)
        i = np.argmax(results)
        label = lb.classes_[i]

        # draw the activity on the output frame
        text = "Monument is: {}".format(label)
        cv2.putText(output, text, (35, 50), cv2.FONT_HERSHEY_SIMPLEX,
            1.25, (0, 255, 0), 5)
        imgArray.append(output)
        # check if the video writer is None
        
    print("[INFO] cleaning up...")
    out = cv2.VideoWriter('project.avi',cv2.VideoWriter_fourcc(*'DIVX'), 15, size)
    for i in range(len(imgArray)):
        out.write(imgArray[i])
    out.release()
    writer.release()
    vs.release()
    return True