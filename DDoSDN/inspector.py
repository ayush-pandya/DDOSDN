import numpy as np
import pandas as pd
#from sklearn.model_selection import train_test_split
from sklearn.preprocessing import StandardScaler
from sklearn.svm import SVC
from sklearn.metrics import confusion_matrix, classification_report
import joblib, warn
import pickle

# filename = 'model.pkl'
# classifier = pickle.load(filename)

with open('model.pkl', 'rb') as handle:
    classifier = pickle.load(handle)

dt_realtime = pd.read_csv('realtime.csv')
result = classifier.predict(dt_realtime)

with open('.result', 'w') as f:
    f.write(str(result[0]))
