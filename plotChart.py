import matplotlib.pyplot as plt

# Data
x = [10000, 50000, 100000]
y = [64, 161, 255]

# Create a line plot
plt.plot(x, y)

# Add titles and labels
plt.title('Peak Latency of `serializedMapStatus` vs # of Tasks')
plt.xlabel('# of Tasks')
plt.ylabel('Peak Latency (ms)')

# Show the plot
plt.savefig("./line_chart.png")