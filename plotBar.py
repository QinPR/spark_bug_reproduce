import matplotlib.pyplot as plt


values = [255, 217]
labels = ['Bug Version', 'Fix Version']


plt.bar(labels, values, color=['blue', 'green'])


plt.title('Bug Version vs. Fix Version')
plt.xlabel('Lat. of `serializedMapStatus` (100000 tasks)')
plt.ylabel('Peak Latency (ms)')


plt.savefig('./bar_graph.png')