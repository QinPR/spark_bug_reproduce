import matplotlib.pyplot as plt
import re

def extract_max_nanoseconds(log_file_path):
    max_nanoseconds = 0
    pattern = r"Time taken for serializedMapStatus: (\d+) nanoseconds"

    with open(log_file_path, 'r') as file:
        for line in file:
            match = re.search(pattern, line)
            if match:
                nanoseconds = int(match.group(1))
                if nanoseconds > max_nanoseconds:
                    max_nanoseconds = nanoseconds
    return max_nanoseconds

log_file_10000 = '/mnt/spark-exp/spark_bug_reproduce/output_10000.txt'
log_file_50000 = '/mnt/spark-exp/spark_bug_reproduce/output_50000.txt'
log_file_100000 = '/mnt/spark-exp/spark_bug_reproduce/output_100000.txt'

max_lat_10000 = extract_max_nanoseconds(log_file_10000) / 1000000
max_lat_50000 = extract_max_nanoseconds(log_file_50000) / 1000000
max_lat_100000 = extract_max_nanoseconds(log_file_100000) / 1000000

# Data
x = [10000, 50000, 100000]
y_fix = [max_lat_10000, max_lat_50000, max_lat_100000]

# Create a line plot
plt.plot(x, y_fix, c='purple', label="fix")

# Add titles and labels
plt.title('Peak Latency of `serializedMapStatus` vs # of Tasks')
plt.xlabel('# of Tasks')
plt.ylabel('Peak Latency (ms)')
plt.legend()

# Show the plot
plt.savefig("./line_chart_fix.png")